class OrdersController < ApplicationController
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

  def create
    define_order
    if @company.active? && @event_type.active?
      successfull_order_creation
    else
      flash[:alert] = t('.inactive')
      redirect_to root_path
    end
  end

  def show
    conflicting_orders = Order.where(company_id: @order.company_id, date: @order.date).where.not(id: @order.id)
    @has_conflict = conflicting_orders.exists?

    @order_approval = @order.order_approval if @order.status == 'negotiating'

    if @order_approval
      extra_charge = @order_approval.extra_charge || 0
      discount = @order_approval.discount || 0
      @final_price = @order.final_price(extra_charge, discount)
    else
      @default_price = @order.default_price
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

  def approve
    return unless request.post?

    handle_approval_process
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

  def successfull_order_creation
    if @order.save
      redirect_to @order, notice: t('.success', code: @order.code)
    else
      flash.now[:alert] = t('.error')
      render :new
    end
  end

  def define_order
    @order = @event_type.orders.new(order_params.merge(client: current_client, local: determine_local))
  end

  def handle_approval_process
    if order_approval_exists?
      handle_existing_approval
    else
      create_and_save_approval
    end
  end

  def order_approval_exists?
    @order.order_approval.present?
  end

  def handle_existing_approval
    flash[:alert] = t('views.approve.already_exists')
    redirect_to order_path(@order)
  end

  def create_and_save_approval
    calculate_final_price
    build_approval

    if @approval.save
      update_order_with_params
      flash[:notice] = t('.success', code: @order.code)
      redirect_to @order
    else
      flash.now[:alert] = t('.error')
      render :approve
    end
  end

  def calculate_final_price
    @order.final_price(params[:order][:extra_charge], params[:order][:discount])
  end

  def build_approval
    @approval = @order.build_order_approval(approval_params.merge(final_price: @order.final_price))
  end

  def update_order_with_params
    update_order_params = { status: :negotiating }
    update_order_params[:payment_method_id] = params[:order][:payment_method_id]
    @order.update(update_order_params)
  end

  def order_params
    params.require(:order).permit(:company_id, :event_type_id, :date,
                                  :attendees_number, :details,
                                  :payment_method_id, :day_type)
  end

  def approval_params
    params.require(:order).permit(:validity_date, :extra_charge, :discount,
                                  :charge_description, :payment_method_id)
          .merge(owner_id: current_owner.id)
  end

  def determine_local
    params[:order][:location_choice] == 'company' ? @event_type.company.address : params[:order][:local]
  end

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
