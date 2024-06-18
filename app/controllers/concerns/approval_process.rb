module ApprovalProcess
  extend ActiveSupport::Concern

  included do
    def approve
      return unless request.post?

      handle_approval_process
    end
  end

  private

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

  def approval_params
    params.require(:order).permit(:validity_date, :extra_charge, :discount,
                                  :charge_description, :payment_method_id)
          .merge(owner_id: current_owner.id)
  end
end
