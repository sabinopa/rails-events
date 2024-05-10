class Owner < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :order_approvals
  has_many :orders, through: :order_approvals
  has_one :company

  validates :name, :lastname, presence: true

  def description
    "#{name} #{lastname} - #{email}"
  end
end
