module OrderCreation
  extend ActiveSupport::Concern

  included do
    def create
      define_order
      if @company.active? && @event_type.active?
        successfull_order_creation
      else
        flash[:alert] = t('.inactive')
        redirect_to root_path
      end
    end
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

  def order_params
    params.require(:order).permit(:company_id, :event_type_id, :date, :attendees_number, :details,
                                  :payment_method_id, :day_type)
  end

  def determine_local
    params[:order][:location_choice] == 'company' ? @event_type.company.address : params[:order][:local]
  end
end
