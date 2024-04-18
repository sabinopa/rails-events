class EventType < ApplicationRecord
  belongs_to :company
  has_many :event_pricings
  accepts_nested_attributes_for :event_pricings

  enum location_type: { on_site: 0, off_site: 1, any_site: 2 }

  validates :name, :description, :min_attendees, :max_attendees,
  :duration, :menu_description, presence: true
end
