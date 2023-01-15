# frozen_string_literal: true

class OrderItemSerializer
  include JSONAPI::Serializer

  attributes :cart_id

  belongs_to :order
  has_many :order_items
end
