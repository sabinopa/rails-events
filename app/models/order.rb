class Order < ApplicationRecord
  belongs_to :company
  belongs_to :event_type
end
