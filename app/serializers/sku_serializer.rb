# frozen_string_literal: true

class SkuSerializer
  include JSONAPI::Serializer

  has_one :variant
end
