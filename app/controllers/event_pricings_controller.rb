class EventPricingsController < ApplicationController
  before_action :authenticate_supplier!, only: [:new, :create]

  def show
    @event_pricing = EventPricing.find(params[:id])
    @event_type = @event_pricing.event_type
    @company = @event_type.company
  end

  def new
    @event_type = EventType.find(params[:event_type_id])
    @event_pricing = EventPricing.new
  end

  def create
    @event_type = EventType.find(params[:event_type_id])
    @event_pricing = @event_type.event_pricings.new(event_pricing_params)
    if @event_pricing.save
      flash[:notice] = t('.success', name: @event_type.name)
      redirect_to event_pricing_path(@event_pricing)
    else
      flash.now[:alert] = t('.error')
      render :new
    end
  end

  private

  def event_pricing_params
    params.require(:event_pricing).permit(:event_type_id, :base_price, :base_attendees,
                                          :additional_guest_price, :extra_hour_price, :weekend)
  end
end