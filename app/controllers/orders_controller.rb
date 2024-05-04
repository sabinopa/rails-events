class OrdersController < ApplicationController
  before_action :authenticate_supplier!, only: [:my_company_orders, :approve]
  before_action :authenticate_client!, only: [:new, :create, :my_orders]
  before_action :set_order, only: [:show, :approve]
  before_action :set_event_type, only: [:new, :create, :show]
  before_action :set_company, only: [:new, :create, :show]

  def new
    @order = Order.new
  end

  def create
    @order = @event_type.orders.new(order_params)
    @order.client = current_client
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
    conflicting_orders = Order.where(company_id: @order.company_id, date: @order.date).where.not(id: @order.id)
    @has_conflict = conflicting_orders.exists?
  end

  def my_orders
    @orders = current_client.orders
  end

  def my_company_orders
    @company = current_supplier.company
    @waiting_review_orders = @company.orders.where(status: 'waiting_review').order(:created_at)
    @negotiating_orders = @company.orders.where(status: 'negotiating').order(:created_at)
    @confirmed_orders = @company.orders.where(status: 'order_confirmed').order(:updated_at)
    @cancelled_orders = @company.orders.where(status: 'order_cancelled').order(:updated_at)
  end

  def approve
    if @order.present? && params[:order].present?
      final_price = calculate_final_price(@order, params[:order][:extra_charge], params[:order][:discount])
      approval = @order.build_order_approval(
        supplier: current_supplier,
        final_price: final_price,
        validity_date: params[:order][:validity_date],
        extra_charge: params[:order][:extra_charge],
        discount: params[:order][:discount],
        charge_description: params[:order][:charge_description],
        payment_method: params[:order][:payment_method],
        approved_at: Time.current
      )

      if approval.save
        @order.update(status: 'order_confirmed')
        flash[:notice] = "Pedido aprovado com sucesso."
        redirect_to @order
      else
        flash.now[:alert] = "Erro ao aprovar o pedido."
        render :approve
      end
    else
      @final_price = @order.calculate_default_price
      render :approve
    end
  end

  private

  def order_params
    params.require(:order).permit(:company_id, :event_type_id, :date, :attendees_number,
                                  :details, :payment_method_id)
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
