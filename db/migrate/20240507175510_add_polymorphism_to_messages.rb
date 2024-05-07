class AddPolymorphismToMessages < ActiveRecord::Migration[7.1]
  def change
    add_reference :messages, :sender, polymorphic: true, null: false
    add_reference :messages, :receiver, polymorphic: true, null: false
  end
end
