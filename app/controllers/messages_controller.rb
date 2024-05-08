class MessagesController < ApplicationController
  before_action :set_order
  before_action :set_users, only: [:create]
  before_action :set_company_and_event_type, only: [:create]

  def create
    @message = @order.messages.build(message_params)
    @message.sender = @current_user
    @message.receiver = @other_user

    if @message.save
      flash[:notice] = t('.success')
      redirect_to @order
    else
      flash.now[:alert] = t('.error')
      render 'orders/show'
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

  def set_users
    if current_supplier
      @current_user = current_supplier
      @other_user = @order.client
    elsif current_client
      @current_user = current_client
      @other_user = @order.supplier
    end
  end

  def message_params
    params.require(:message).permit(:body, :sender_id, :sender_type, :receiver_id, :receiver_type)
  end
end
