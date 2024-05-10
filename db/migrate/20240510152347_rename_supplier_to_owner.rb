class RenameSupplierToOwner < ActiveRecord::Migration[7.1]
  def change
    rename_column :companies, :supplier_id, :owner_id
    rename_column :order_approvals, :supplier_id, :owner_id
    rename_index :companies, 'index_companies_on_supplier_id', 'index_companies_on_owner_id'
    rename_index :order_approvals, 'index_order_approvals_on_supplier_id', 'index_order_approvals_on_owner_id'
  end
end
