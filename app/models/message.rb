class Message < ApplicationRecord
  belongs_to :order
  belongs_to :sender, polymorphic: true
  belongs_to :receiver, polymorphic: true

  validates :body, presence: true
end
