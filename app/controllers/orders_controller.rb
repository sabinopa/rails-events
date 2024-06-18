class OrdersController < ApplicationController
  include ApprovalProcess
  include OrderManagement

  before_action :authenticate_owner!, only: %i[my_company_orders approve]
  before_action :authenticate_client!, only: %i[new create my_orders confirm]
  before_action :set_order, only: %i[show approve confirm cancel]
  before_action :set_event_type, only: %i[new create show approve confirm cancel]
  before_action :set_company, only: %i[new create show approve confirm cancel]
  before_action :check_user, only: %i[show cancel]
  before_action :update_order_status, only: %i[show my_company_orders my_orders]
  before_action :set_messages, only: %i[show]

  def new
    if @company.inactive?
      flash[:alert] = t('.inactive_company')
      redirect_to root_path
    elsif @event_type.inactive?
      flash[:alert] = t('.inactive_event_type')
      redirect_to root_path
    else
      @order = Order.new
      @order.local = @company.address if @event_type.on_site?
    end
  end

  def my_orders
    @orders = current_client.orders.sorted_by_status
  end

  def my_company_orders
    @company = current_owner.company
    @waiting_review_orders = @company.orders.where(status: 'waiting_review').order(:created_at)
    @negotiating_orders = @company.orders.where(status: 'negotiating').order(:created_at)
    @confirmed_orders = @company.orders.where(status: 'order_confirmed').order(:updated_at)
    @cancelled_orders = @company.orders.where(status: 'order_cancelled').order(:updated_at)
  end

  def confirm
    @approval = @order.order_approval
    if @approval && @approval.validity_date >= Date.today
      @order.update(status: 'order_confirmed')
      flash[:notice] = t('.success', code: @order.code)
      redirect_to @order
    else
      flash.now[:alert] = t('.expired')
      render :show
    end
  end

  def cancel
    @order.update(status: 'order_cancelled')
    flash[:notice] = t('.cancelled', code: @order.code)
    redirect_to @order
  end

  private

  def set_messages
    @message = params[:id] ? Message.find_by(id: params[:id]) : Message.new
    @messages = @order.messages.order(created_at: :asc) if @order.present?
  end

  def set_order
    @order = Order.find(params[:id])
  end

  def set_company
    @company = @event_type.company
  end

  def set_event_type
    @event_type = EventType.find(params[:event_type_id] || @order.event_type_id)
  end

  def update_order_status
    Order.check_date_and_update_status
  end

  def check_user
    return if current_owner == @order.company.owner || current_client == @order.client

    flash[:notice] = t('.error')
    redirect_to root_path
  end
end
