class ChangeDayOptionsToIntegerInEventPricings < ActiveRecord::Migration[7.1]
  def change
    change_column(:event_pricings, :day_options, :integer)
  end
end
