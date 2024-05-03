class ChangePaymentMethodIdNullConstraintOnOrders < ActiveRecord::Migration[7.1]
  def change
    change_column_null :orders, :payment_method_id, true
  end
end
