class EventType < ApplicationRecord
  belongs_to :company
  has_many :event_pricings
  has_many :orders
  has_many_attached :photos
  accepts_nested_attributes_for :event_pricings

  enum location_type: { on_site: 0, off_site: 1, any_site: 2 }

  validates :name, :description, :min_attendees, :max_attendees,
            :duration, :menu_description, presence: true

  def calculate_base_price(day_type, number_attendees)
    event_pricing = event_pricings.find_by(day_options: day_type) || event_pricings.first
    return 0 unless event_pricing

    base_price = event_pricing.base_price
    additional_attendees = [number_attendees - event_pricing.base_attendees, 0].max
    additional_cost = additional_attendees * event_pricing.additional_attendee_price
    base_price + additional_cost
  end
end
