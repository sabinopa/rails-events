class EventPricingsController < ApplicationController
  before_action :authenticate_owner!, only: [:new, :create, :edit, :update]
  before_action :set_event_pricing, only: [:edit, :update]
  before_action :set_event_type, only: [:new, :create, :edit, :update]
  before_action :set_company, only: [:new, :create, :edit, :update]
  before_action :check_owner, only: [:new, :create, :edit, :update]

  def new
    @event_pricing = EventPricing.new
  end

  def create
    @event_pricing = @event_type.event_pricings.new(event_pricing_params)
    if pricing_exists?
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
    if pricing_exists? && !same_day_option?
      flash.now[:alert] = t('.duplicate_day_option')
      render :edit
    elsif @event_pricing.update(event_pricing_params)
      flash[:notice] = t('.success', name: @event_type.name)
      redirect_to @event_type
    else
      flash.now[:alert] = t('.error')
      render :edit
    end
  end

  private

  def pricing_exists?
    @event_type.event_pricings.exists?(day_options: event_pricing_params[:day_options])
  end

  def same_day_option?
    existing = @event_type.event_pricings.find_by(day_options: event_pricing_params[:day_options])
    existing && existing.id == @event_pricing.id
  end

  def set_company
    @company = @event_type.company
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
    if current_owner != @event_type.company.owner
      flash[:alert] = t('.error')
      redirect_to root_path
    end
  end
end