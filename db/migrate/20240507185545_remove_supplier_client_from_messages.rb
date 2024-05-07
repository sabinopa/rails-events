class RemoveSupplierClientFromMessages < ActiveRecord::Migration[7.1]
  def change
    remove_column :messages, :supplier_id, :integer
    remove_column :messages, :client_id, :integer
  end
end
