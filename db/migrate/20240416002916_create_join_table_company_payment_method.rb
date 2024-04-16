class CreateJoinTableCompanyPaymentMethod < ActiveRecord::Migration[7.1]
  def change
    create_join_table :companies, :payment_methods do |t|
      t.index [:company_id, :payment_method_id]
      t.index [:payment_method_id, :company_id]
    end
  end
end
