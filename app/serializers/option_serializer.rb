# frozen_string_literal: true

class OptionSerializer
  include JSONAPI::Serializer

  attributes :id, :name
  has_many :option_values, lazy_load_data: true
end
