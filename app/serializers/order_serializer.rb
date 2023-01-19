# frozen_string_literal: true

class OrderSerializer
  include JSONAPI::Serializer

  attributes :cart_id, :status

  belongs_to :cart
  has_many :items, serializer: :order_item
end
