# frozen_string_literal: true

class ProductSerializer
  include JSONAPI::Serializer

  attributes :slug,
             :brand_id,
             :category_id,
             :name,
             :description,
             :meta
  attribute :images do |object|
    object.images.map(&:image_url)
  end

  belongs_to :brand
  has_one :category
  # has_many :images
  has_many :variants
end
