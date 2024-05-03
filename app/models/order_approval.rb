class OrderApproval < ApplicationRecord
  belongs_to :order
  belongs_to :supplier
end
