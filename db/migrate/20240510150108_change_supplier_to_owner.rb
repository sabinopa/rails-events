class ChangeSupplierToOwner < ActiveRecord::Migration[7.1]
  def change
    rename_table :suppliers, :owners
  end
end
