# frozen_string_literal: true

class CategorySerializer
  include JSONAPI::Serializer

  attributes :name, :slug, :meta
  has_many :products
end
