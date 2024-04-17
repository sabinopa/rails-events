class RenameEventPricingColumns < ActiveRecord::Migration[7.1]
  def change
    rename_column :event_pricings, :weekend, :day_options
    rename_column :event_pricings, :additional_attendee_price, :additional_attendee_price
  end
end
