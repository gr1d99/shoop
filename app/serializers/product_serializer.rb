class ProductSerializer
  include JSONAPI::Serializer

  attributes :brand_id,
             :category_id,
             :name,
             :description,
             :images,
             :meta
  belongs_to :brand
  has_one :category
end
