class OrdersController < ApplicationController
  before_action :authenticate_client!, only: [:new, :create]
  before_action :set_event_type, only: [:new, :create]
  before_action :set_company, only: [:new, :create]

  def new
    @order = Order.new
  end

  def create
    @order = @event_type.orders.new(order_params)
    @company = @order.company
    if @order.save
      flash[:notice] = t('.success', code: @order.code)
      redirect_to @order
    else
      flash.now[:alert] = t('.error')
      render :new
    end
  end

  private

  def order_params
    params.require(:order).permit(:company_id, :event_type_id, :date,
                                  :attendees_number, :details, :local)
  end

  def set_company
    @company = @event_type.company
  end

  def set_event_type
    @event_type = EventType.find(params[:event_type_id])
  end

end