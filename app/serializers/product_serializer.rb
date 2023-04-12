# frozen_string_literal: true

class ProductSerializer
  include JSONAPI::Serializer
  include Rails.application.routes.url_helpers

  attributes :slug, :brand_id, :category_id, :name, :description, :meta
  attribute :images do |object|
    image_host = Rails.env.production? ? '' : 'http://localhost:3000'
    object.images.map do |image|
      { id: image.id, name: image.name, alt: image.alt, url: image.image_url(host: image_host) }
    end
  end

  belongs_to :brand
  has_one :master, serializer: :variants
  has_one :category
  has_many :variants
end
