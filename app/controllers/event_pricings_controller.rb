class EventPricingsController < ApplicationController
  before_action :authenticate_owner!, only: %i[new create edit update]
  before_action :set_event_pricing, only: %i[edit update]
  before_action :set_event_type, only: %i[new create edit update]
  before_action :set_company, only: %i[new create edit update]
  before_action :check_owner, only: %i[new create edit update]

  def new
    @event_pricing = EventPricing.new
  end

  def create
    @event_pricing = @event_type.event_pricings.new(event_pricing_params)
    if pricing_exists?
      handle_duplicate_day_option
    elsif @event_pricing.save
      flash[:notice] = t('.success', name: @event_type.name)
      redirect_to @event_type
    else
      flash.now[:alert] = t('.error')
      render :new
    end
  end

  def edit; end

  def update
    if duplicate_day_option?
      handle_duplicate_day_option
    elsif update_event_pricing
      handle_successful_update
    else
      handle_failed_update
    end
  end

  private

  def duplicate_day_option?
    pricing_exists? && !same_day_option?
  end

  def handle_duplicate_day_option
    flash.now[:alert] = t('.duplicate_day_option')
    render :edit
  end

  def update_event_pricing
    @event_pricing.update(event_pricing_params)
  end

  def handle_successful_update
    flash[:notice] = t('.success', name: @event_type.name)
    redirect_to @event_type
  end

  def handle_failed_update
    flash.now[:alert] = t('.error')
    render :edit
  end

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
    @event_type = if params[:event_type_id]
                    EventType.find(params[:event_type_id])
                  else
                    @event_pricing.event_type
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
    return unless current_owner != @event_type.company.owner

    flash[:alert] = t('.error')
    redirect_to root_path
  end
end
