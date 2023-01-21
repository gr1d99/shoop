# frozen_string_literal: true

class ShippingAddressSerializer
  include JSONAPI::Serializer

  attributes :first_name, :last_name, :phone, :description, :user_id, :town_id

  belongs_to :user
  belongs_to :town
end
