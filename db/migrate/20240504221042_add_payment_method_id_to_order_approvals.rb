class AddPaymentMethodIdToOrderApprovals < ActiveRecord::Migration[7.1]
  def change
    add_column :order_approvals, :payment_method_id, :integer
  end
end
