class BrandSerializer
  include JSONAPI::Serializer

  attributes :slug, :name, :meta
  has_many :products
end
