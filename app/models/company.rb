class Company < ApplicationRecord
  belongs_to :supplier
  has_many :event_types
  has_and_belongs_to_many :payment_methods

  accepts_nested_attributes_for :payment_methods

  validates :brand_name, :corporate_name, :registration_number, :phone_number,
            :email, :address, :neighborhood, :city, :state, :zipcode, :description,
            presence: true

  def self.search(query_params)
    query = "%#{query_params}%"
    Company.left_joins(:event_types)
           .where("companies.brand_name LIKE :query OR companies.city LIKE :query OR event_types.name LIKE :query", query: query)
           .distinct.order(:brand_name)
  end
end
