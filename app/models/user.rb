# frozen_string_literal: true

class User < ApplicationRecord
  acts_as_paranoid

  has_secure_password

  default_scope -> { order :created_at }

  has_many :products, foreign_key: :created_by_id, dependent: :destroy, inverse_of: :created_by
  has_many :carts, inverse_of: :user, dependent: :destroy
  has_many :shipping_addresses, dependent: :destroy
  has_one :current_cart, lambda {
                           Cart
                             .left_joins(:order).where('orders.cart_id IS NULL')
                             .or(Cart.left_joins(:order).where("orders.status='pending'"))
                         }, dependent: :destroy, class_name: 'Cart', inverse_of: :user

  with_options presence: true do
    validates :first_name
    validates :last_name
    validates :email, uniqueness: true
    validates :phone, uniqueness: true
    validates :password
  end

  # Custom queries
  def orders
    Order.includes(cart: :user).where({ carts: { user_id: id } })
  end

  # Auth token
  def generate_jwt
    JWT.encode({ identity: email, exp: 7.days.from_now.to_i }, Rails.application.secrets.secret_key_base)
  end
end
