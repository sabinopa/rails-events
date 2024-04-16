class EventType < ApplicationRecord
  belongs_to :company

  enum location_type: { on_site: 0, off_site: 1 }

  validates :name, :description, :min_attendees, :max_attendees,
  :duration, :menu_description, presence: true
end
