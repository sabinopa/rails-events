class AddUniqueIndexToDocumentNumberInClients < ActiveRecord::Migration[7.1]
  def change
    add_index :clients, :document_number, unique: true
  end
end
