class Company < ApplicationRecord
  belongs_to :owner
  has_many :event_types
  has_many :orders
  has_many :reviews
  has_and_belongs_to_many :payment_methods

  accepts_nested_attributes_for :payment_methods

  validates :brand_name, :corporate_name, :registration_number, :phone_number,
            :email, :address, :neighborhood, :city, :state, :zipcode, :description,
            presence: true
  validates :owner_id, :registration_number, uniqueness: true

  validates_cnpj_format_of :registration_number

  enum status: { inactive: 0, active: 1 }

  def self.search(query_params)
    query = "%" + sanitize_sql_like(query_params) + "%"
    Company.active
           .left_joins(:event_types)
           .where("companies.brand_name LIKE :q OR companies.city LIKE :q OR event_types.name LIKE :q AND event_types.status = :active_status",
                  q: query, active_status: EventType.statuses[:active])
           .distinct
           .order(:brand_name)
  end

  def average_score
    reviews.any? ? reviews.pluck(:score).sum.to_f / reviews.count : 0
  end
end
