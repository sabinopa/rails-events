class Company < ApplicationRecord
  belongs_to :supplier
  has_and_belongs_to_many :payment_methods

  accepts_nested_attributes_for :payment_methods
end
