class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.references :company, null: false, foreign_key: true
      t.references :event_type, null: false, foreign_key: true
      t.date :date
      t.integer :attendees_number
      t.text :details
      t.string :local
      t.string :code
      t.integer :status

      t.timestamps
    end
  end
end
