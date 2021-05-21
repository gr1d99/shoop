class User < ApplicationRecord
  has_secure_password

  has_many :products, foreign_key: :created_by, dependent: :destroy

  with_options presence: true do
    validates :first_name
    validates :last_name
    validates :email, uniqueness: true
    validates :phone, uniqueness: true
    validates :password
  end
end
