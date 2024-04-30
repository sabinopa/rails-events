class Order < ApplicationRecord
  belongs_to :company
  belongs_to :event_type

  validates :date, :attendees_number, :details, presence: true
  validates :attendees_number, numericality: { greater_than: 0 }
end
