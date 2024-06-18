module OrderShow
  extend ActiveSupport::Concern

  included do
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
  end
end
