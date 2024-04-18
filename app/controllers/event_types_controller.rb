class EventTypesController < ApplicationController
  before_action :authenticate_supplier!, only: [:new, :create]
  before_action :check_owner, only: [:new, :create]

  def show
    @event_type = EventType.find(params[:id])
    @company = @event_type.company
  end
  def new
    @company = Company.find(params[:company_id])
    @event_type = EventType.new
  end

  def create
    @company = Company.find(params[:company_id])
    @event_type = @company.event_types.new(event_type_params)
    if @event_type.save
      flash[:notice] = t('.success', name: @event_type.name)
      redirect_to @company
    else
      flash.now[:alert] = t('.error')
      render :new
    end
  end

  private

  def event_type_params
    params.require(:event_type).permit(:name, :description, :min_attendees,
                                      :max_attendees, :duration, :menu_description,
                                      :alcohol_available, :decoration_available,
                                      :parking_service_available,
                                      :location_type, :company_id)
  end

  def check_owner
    @company = Company.find(params[:company_id])
    if current_supplier != @company.supplier
      flash[:alert] = t('.error')
      redirect_to root_path
    end
  end
end