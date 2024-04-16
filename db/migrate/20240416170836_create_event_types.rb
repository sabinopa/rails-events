class CreateEventTypes < ActiveRecord::Migration[7.1]
  def change
    create_table :event_types do |t|
      t.string :name
      t.text :description
      t.integer :min_attendees
      t.integer :max_attendees
      t.integer :duration
      t.text :menu_description
      t.boolean :alcohol_available
      t.boolean :decoration_available
      t.boolean :parking_service_available
      t.integer :location_type
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
