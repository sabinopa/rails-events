class Order < ApplicationRecord
  attr_accessor :location_choice

  belongs_to :company
  belongs_to :event_type
  belongs_to :client
  belongs_to :payment_method, optional: true

  validates :date, :attendees_number, :details, :local, presence: true
  validates :attendees_number, numericality: { greater_than: 0 }
  validates :code, uniqueness: true

  before_validation :generate_code, on: :create

  enum status: { waiting_confirmation: 0, order_confirmed: 1, order_cancelled: 2 }

  private

  def generate_code
    self.code = SecureRandom.alphanumeric(8).upcase
  end
end
