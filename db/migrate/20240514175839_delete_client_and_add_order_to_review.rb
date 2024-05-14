class DeleteClientAndAddOrderToReview < ActiveRecord::Migration[7.1]
  def change
    remove_reference :reviews, :client, index: true, foreign_key: true
    add_reference :reviews, :order, null: false, index: true, foreign_key: true
  end
end
