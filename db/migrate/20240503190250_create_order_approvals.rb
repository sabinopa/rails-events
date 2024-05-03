class CreateOrderApprovals < ActiveRecord::Migration[7.1]
  def change
    create_table :order_approvals do |t|
      t.references :order, null: false, foreign_key: true
      t.references :supplier, null: false, foreign_key: true
      t.decimal :final_price
      t.date :validity_date
      t.decimal :extra_charge
      t.decimal :discount
      t.string :charge_description
      t.datetime :approved_at

      t.timestamps
    end
  end
end
