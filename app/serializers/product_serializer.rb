# frozen_string_literal: true

class ProductSerializer
  include JSONAPI::Serializer

  attributes :slug,
             :brand_id,
             :category_id,
             :name,
             :description,
             :images,
             :meta
  belongs_to :brand
  has_one :category
  has_many :variants
end
