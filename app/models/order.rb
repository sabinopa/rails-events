class Order < ApplicationRecord
  attr_accessor :location_choice

  has_one :order_approval
  belongs_to :company
  belongs_to :event_type
  belongs_to :client
  belongs_to :payment_method, optional: true
  has_many :suppliers, through: :order_approvals

  validates :date, :attendees_number, :details, :local, :day_type, presence: true
  validates :attendees_number, numericality: { greater_than: 0 }
  validates :code, uniqueness: true

  before_validation :generate_code, on: :create

  enum status: { waiting_review: 0, negotiating: 1, order_confirmed: 2, order_cancelled: 3 }

  def self.check_date_and_update_status
    where(status: 'negotiating').each do |order|
      if order.order_approval&.validity_date && order.order_approval.validity_date < Date.today
        order.update(status: 'order_cancelled')
      end
    end
  end

  def default_price
    calculate_default_price
  end

  def final_price(extra_charge = 0, discount = 0)
    extra_charge = order_approval&.extra_charge || 0
    discount = order_approval&.discount || 0
    calculate_final_price(extra_charge, discount)
  end


  private

  def calculate_default_price
    event_pricing = select_event_pricing(self.event_type, self.date)
    return 0 unless event_pricing

    base_price = event_pricing.base_price
    additional_attendees = self.attendees_number - event_pricing.base_attendees
    additional_cost = additional_attendees.positive? ? additional_attendees * event_pricing.additional_attendee_price : 0
    base_price + additional_cost
  end

  def calculate_final_price(extra_charge, discount)
    default_price = calculate_default_price
    final_price = default_price + extra_charge.to_f - discount.to_f
    final_price
  end

  def select_event_pricing(event_type, day_type)
    event_type.event_pricings.find_by(day_options: day_type) || event_type.event_pricings.first
  end

  def generate_code
    self.code = SecureRandom.alphanumeric(8).upcase
  end
end
