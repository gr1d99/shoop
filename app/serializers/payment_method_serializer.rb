# frozen_string_literal: true

class PaymentMethodSerializer
  include JSONAPI::Serializer

  attributes :name, :description
end
