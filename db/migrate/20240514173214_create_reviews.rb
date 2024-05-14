class CreateReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :reviews do |t|
      t.references :company, null: false, foreign_key: true
      t.integer :score
      t.text :text
      t.references :client, null: false, foreign_key: true

      t.timestamps
    end
  end
end
