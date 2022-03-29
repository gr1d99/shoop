class VariantSerializer
  include JSONAPI::Serializer

  belongs_to :product
end
