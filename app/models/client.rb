class Client < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, :lastname, :document_number, presence: true
  validates :document_number, uniqueness: true
  validates_cpf_format_of :document_number

  def description
    "#{name} #{lastname} - #{email}"
  end
end
