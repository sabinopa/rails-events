class AddDayTypeToOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :day_type, :string
  end
end
