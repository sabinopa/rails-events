class RenameOwnerToSupplier < ActiveRecord::Migration[7.1]
  def change
    rename_table :owners, :suppliers
  end
end
