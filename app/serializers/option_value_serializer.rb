# frozen_string_literal: true

class OptionValueSerializer
  include JSONAPI::Serializer

  attributes :id, :name
  belongs_to :option
end
