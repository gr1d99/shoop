# frozen_string_literal: true

class UserSerializer
  include JSONAPI::Serializer

  attributes :email, :phone, :first_name, :last_name

  attribute :current_cart do |user|
    user.carts
        .left_joins(:order).where('orders.cart_id IS NULL')
        .or(user.carts.left_joins(:order).where("orders.status='pending' ")).order('created_at').first
  end

  has_one :current_cart, serializer: CartSerializer
  has_many :carts
end
