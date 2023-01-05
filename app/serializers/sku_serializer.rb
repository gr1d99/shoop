# frozen_string_literal: true

class SkuSerializer
  include JSONAPI::Serializer

  has_one :variant
  has_many :cart_items
end
