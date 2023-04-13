# frozen_string_literal: true

class CartSerializer
  include JSONAPI::Serializer

  attributes :id, :user_id
  belongs_to :user
  has_many :items, class_name: 'CartItem', serializer: CartItemSerializer
end
