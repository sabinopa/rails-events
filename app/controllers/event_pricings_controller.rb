class EventPricingsController < ApplicationController
  before_action :authenticate_supplier!, only: [:new, :create, :edit, :update]
  before_action :set_event_pricing, only: [:edit, :update]
  before_action :set_event_type, only: [:new, :create, :edit, :update, :index]
  before_action :set_company, only: [:new, :create, :edit, :update]
  before_action :check_owner, only: [:new, :create, :edit, :update]

  def index
    @event_pricings = @event_type.event_pricings
    @company = @event_type.company
  end

  def new
    @event_pricing = EventPricing.new
  end

  def create
    @event_pricing = @event_type.event_pricings.new(event_pricing_params)
    if @event_type.event_pricings.exists?(day_options: event_pricing_params[:day_options])
      flash.now[:alert] = t('.duplicate_day_option')
      render :new
    elsif @event_pricing.save
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
    if @event_pricing.update(event_pricing_params)
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
    if params[:event_type_id]
      @event_type = EventType.find(params[:event_type_id])
    else
      @event_type = @event_pricing.event_type
    end
  end

  def set_event_pricing
    @event_pricing = EventPricing.find(params[:id])
  end

  def event_pricing_params
    params.require(:event_pricing).permit(:event_type_id, :base_price, :base_attendees,
                                          :additional_attendee_price, :extra_hour_price, :day_options)
  end

  def check_owner
    if current_supplier != @event_type.company.supplier
      flash[:alert] = t('.error')
      redirect_to root_path
    end
  end
end