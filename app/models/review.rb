class Review < ApplicationRecord
  belongs_to :company
  belongs_to :order
  has_many_attached :photos
  delegate :client, to: :order

  validates :score, presence: true, inclusion: { in: 0..5 }
  validates :text, presence: true
  validates :order_id, uniqueness: { message: :one_review }
end
