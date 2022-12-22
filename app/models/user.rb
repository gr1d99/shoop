# frozen_string_literal: true

class User < ApplicationRecord
  acts_as_paranoid

  has_secure_password

  has_many :products, foreign_key: :created_by_id, dependent: :destroy

  with_options presence: true do
    validates :first_name
    validates :last_name
    validates :email, uniqueness: true
    validates :phone, uniqueness: true
    validates :password
  end

  def generate_jwt
    JWT.encode({ identity: email, exp: 7.days.from_now.to_i }, Rails.application.secrets.secret_key_base)
  end
end
