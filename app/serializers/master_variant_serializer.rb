# frozen_string_literal: true

class MasterVariantSerializer
  include JSONAPI::Serializer

  attributes :name,
             :price
  attribute :sku_no do |object|
    object.sku.sku_no
  end
end
