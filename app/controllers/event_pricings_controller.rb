class EventPricingsController < ApplicationController
  before_action :authenticate_supplier!, only: [:new, :create]

  def show

  end

  def new
    @event_type = EventType.find(params[:event_type_id])
    @event_pricing = EventPricing.new
  end

  def create

  end
end