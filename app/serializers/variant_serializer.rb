# frozen_string_literal: true

class VariantSerializer
  include JSONAPI::Serializer

  belongs_to :product
  belongs_to :sku
  has_many :option_values

  attributes :is_master, :price, :product_id, :sku_id
end
