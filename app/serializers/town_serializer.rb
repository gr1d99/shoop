# frozen_string_literal: true

class TownSerializer
  include JSONAPI::Serializer

  attributes :name, :county_id

  belongs_to :county
end
