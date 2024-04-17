class EventPricingsController < ApplicationController
  before_action :authenticate_supplier!, only: [:new, :create]
  before_action :check_owner, only: [:new, :create]

  def index
    @event_type = EventType.find(params[:event_type_id])
    @event_pricings = @event_type.event_pricings
    @company = @event_type.company
  end

  def new
    @event_type = EventType.find(params[:event_type_id])
    @event_pricing = EventPricing.new
  end

  def create
    @event_type = EventType.find(params[:event_type_id])
    @event_pricing = @event_type.event_pricings.new(event_pricing_params)
    if @event_type.event_pricings.exists?(day_options: event_pricing_params[:day_options])
      flash.now[:alert] = t('.duplicate_day_option')
      render :new
    elsif @event_pricing.save
      flash[:notice] = t('.success', name: @event_type.name)
      redirect_to [@event_type, :event_pricings]
    else
      flash.now[:alert] = t('.error')
      render :new
    end
  end

  private

  def event_pricing_params
    params.require(:event_pricing).permit(:event_type_id, :base_price, :base_attendees,
                                          :additional_attendee_price, :extra_hour_price, :day_options)
  end

  def check_owner
    @event_type = EventType.find(params[:event_type_id])
    if current_supplier != @event_type.company.supplier
      flash[:alert] = t('.error')
      redirect_to root_path
    end
  end
end