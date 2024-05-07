class Message < ApplicationRecord
  belongs_to :order
  belongs_to :supplier
  belongs_to :client
end
