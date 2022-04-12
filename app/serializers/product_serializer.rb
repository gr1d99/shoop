# frozen_string_literal: true

class ProductSerializer
  include JSONAPI::Serializer

  attribute :master_variant do |object|
    MasterVariantSerializer.new(object.master).to_hash
  end
  attributes :slug,
             :brand_id,
             :category_id,
             :name,
             :description,
             :meta
  attribute :images do |object|
    object.images.map { |image| { id: image.id, name: image.name, alt: image.alt, url: image.image_url } }
  end

  belongs_to :brand
  has_one :category
  has_many :variants
end
