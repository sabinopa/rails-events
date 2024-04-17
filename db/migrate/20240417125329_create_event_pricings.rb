class CreateEventPricings < ActiveRecord::Migration[7.1]
  def change
    create_table :event_pricings do |t|
      t.references :event_type, null: false, foreign_key: true
      t.decimal :base_price, precision: 10, scale: 2
      t.integer :base_attendees
      t.decimal :additional_guest_price, precision: 10, scale: 2
      t.decimal :extra_hour_price, precision: 10, scale: 2
      t.boolean :weekend

      t.timestamps
    end
  end
end
