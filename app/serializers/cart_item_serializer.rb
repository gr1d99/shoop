# frozen_string_literal: true

class CartItemSerializer
  include JSONAPI::Serializer

  attributes :id, :cart_id, :sku_id, :product_id, :amount, :quantity
  belongs_to :cart
  belongs_to :product
  belongs_to :sku
end
