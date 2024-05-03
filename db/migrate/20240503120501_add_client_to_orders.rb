class AddClientToOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :client_id, :integer
    add_index :orders, :client_id
  end
end
