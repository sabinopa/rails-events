class EventTypesController < ApplicationController
  before_action :authenticate_supplier!, only: [:new, :create, :edit, :update]
  before_action :set_event_type, only: [:edit, :update, :show]
  before_action :set_company, only: [:new, :create, :edit, :update]
  before_action :check_owner, only: [:new, :create, :edit, :update]

  def show
    @company = @event_type.company
  end
  def new
    @event_type = EventType.new
  end

  def create
    @event_type = @company.event_types.new(event_type_params)
    if @event_type.save
      flash[:notice] = t('.success', name: @event_type.name)
      redirect_to @event_type
    else
      flash.now[:alert] = t('.error')
      render :new
    end
  end

  def edit
  end

  def update
    if @event_type.update(event_type_params)
      flash[:notice] = t('.success', name: @event_type.name)
      redirect_to @event_type
    else
      flash.now[:alert] = t('.error')
      render :edit
    end
  end

  private

  def set_company
    if params[:company_id]
      @company = Company.find(params[:company_id])
    else
      @company = @event_type.company
    end
  end

  def set_event_type
    @event_type = EventType.find(params[:id])
  end


  def event_type_params
    params.require(:event_type).permit(:name, :description, :min_attendees,
                                      :max_attendees, :duration, :menu_description,
                                      :alcohol_available, :decoration_available,
                                      :parking_service_available,
                                      :location_type, :pictures, :company_id)
  end

  def check_owner
    if current_supplier != @company.supplier
      flash[:alert] = t('.error')
      redirect_to root_path
    end
  end
end