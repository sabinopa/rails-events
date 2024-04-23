class Client < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, :lastname, :document_number, presence: true
  validates :document_number, uniqueness: true, format: { with: /\A\d{3}\.\d{3}\.\d{3}\-\d{2}\z/, message: I18n.t('errors.messages.document_number_format') }

  def description
    "#{name} #{lastname} - #{email}"
  end
end
