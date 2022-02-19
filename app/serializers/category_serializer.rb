class CategorySerializer
  include JSONAPI::Serializer

  attributes :name, :meta
  has_many :products
end
