class MessagesController < ApplicationController
  before_action :set_order
  before_action :authenticate_participant
  before_action :set_participants, only: [:create, :index]
  before_action :set_company_and_event_type, only: [:create, :index]

  def index
    @message = Message.new
    if @order
      @messages = @order.messages.order(created_at: :asc)
    else
      redirect_to some_error_path, alert: "Order not found."
    end
  end

  def create
    @message = Message.new
    @message = @order.messages.build(message_params)
    @message.sender = @current_participant
    @message.receiver = @other_participant

    if @message.save
      flash[:notice] = t('.success')
      redirect_to order_messages_path(@order)
    else
      flash.now[:alert] = t('.error')
      render :index
    end
  end

  private

  def set_order
    @order = Order.find(params[:order_id])
  end

  def set_company_and_event_type
    @company = @order.company
    @event_type = @order.event_type
  end

  def set_participants
    if current_supplier
      @current_participant = current_supplier
      @other_participant = @order.client
    elsif current_client
      @current_participant = current_client
      @other_participant = @order.supplier
    end
  end

  def message_params
    params.require(:message).permit(:body, :sender_id, :sender_type, :receiver_id, :receiver_type)
  end

  def authenticate_participant
    unless current_supplier == @order.company.supplier || current_client == @order.client
      redirect_to root_path, alert: "You do not have permission to access this section."
    end
  end

end
