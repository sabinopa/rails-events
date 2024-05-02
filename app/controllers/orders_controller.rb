class OrdersController < ApplicationController
  before_action :authenticate_client!, only: [:new, :create]
  before_action :set_order, only: :show
  before_action :set_event_type, only: [:new, :create, :show]
  before_action :set_company, only: [:new, :create, :show]

  def new
    @order = Order.new
  end

  def create
    @order = @event_type.orders.new(order_params)
    @order.location_choice = params[:order][:location_choice]
    @order.local = determine_local(@order.location_choice)

    if @order.save
      flash[:notice] = t('.success', code: @order.code)
      redirect_to @order
    else
      flash.now[:alert] = t('.error')
      render :new
    end
  end

  def show
  end

  private

  def order_params
    params.require(:order).permit(:company_id, :event_type_id, :date, :attendees_number, :details)
  end

  def determine_local(location_choice)
    if location_choice == 'company'
      @event_type.company.address
    else
      params[:order][:local]
    end
  end

  def set_order
    @order = Order.find(params[:id])
  end

  def set_company
    @company = @event_type.company
  end

  def set_event_type
    if params[:event_type_id]
      @event_type = EventType.find(params[:event_type_id])
    else
      @event_type = @order.event_type
    end
  end
end
