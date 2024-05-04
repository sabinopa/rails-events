class Order < ApplicationRecord
  require 'holidays'

  WEEKEND = 'weekend'.freeze
  HOLIDAY = 'holiday'.freeze
  WEEKDAY = 'weekday'.freeze

  attr_accessor :location_choice

  has_one :order_approval
  belongs_to :company
  belongs_to :event_type
  belongs_to :client
  belongs_to :payment_method, optional: true

  validates :date, :attendees_number, :details, :local, presence: true
  validates :attendees_number, numericality: { greater_than: 0 }
  validates :code, uniqueness: true

  before_validation :generate_code, on: :create

  enum status: { waiting_review: 0, negotiating: 1, order_confirmed: 2, order_cancelled: 3 }

  def calculate_default_price
    event_pricing = select_event_pricing(self.event_type, self.date)
    return 0 unless event_pricing

    base_price = event_pricing.base_price
    additional_attendees = self.attendees_number - event_pricing.base_attendees
    additional_cost = additional_attendees.positive? ? additional_attendees * event_pricing.additional_attendee_price : 0
    total_price = base_price + additional_cost
    total_price
  end

  def calculate_final_price(extra_charge, discount)
    default_price = calculate_default_price
    final_price = default_price + extra_charge.to_f - discount.to_f
    final_price
  end

  private

  def select_event_pricing(event_type, date)
    day_option = determine_day_option(date)
    event_type.event_pricings.find_by(day_options: day_option) || event_type.event_pricings.first
  end

  def determine_day_option(date)
    if date.saturday? || date.sunday?
      WEEKEND
    elsif Holidays.on(date, :br).any?
      HOLIDAY
    else
      WEEKDAY
    end
  end

  def generate_code
    self.code = SecureRandom.alphanumeric(8).upcase
  end
end
