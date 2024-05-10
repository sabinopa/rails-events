class OrderApproval < ApplicationRecord
  belongs_to :order
  belongs_to :owner
  belongs_to :payment_method, optional: true

  validates :validity_date, presence: true
end
