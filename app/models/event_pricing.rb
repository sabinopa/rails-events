class EventPricing < ApplicationRecord
  belongs_to :event_type

  validates :base_price, :base_attendees, :additional_attendee_price,
            :extra_hour_price, presence: true

  enum day_options: { weekday: 0, weekend: 1, holiday: 2 }
end
