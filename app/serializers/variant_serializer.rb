# frozen_string_literal: true

class VariantSerializer
  include JSONAPI::Serializer

  belongs_to :product
end
