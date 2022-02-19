class ProductSerializer
  include JSONAPI::Serializer

  attributes :name, :price, :description, :images, :meta
end
