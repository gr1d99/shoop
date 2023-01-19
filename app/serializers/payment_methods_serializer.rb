# frozen_string_literal: true

class PaymentMethodsSerializer
  include JSONAPI::Serializer

  attributes :name, :description
end
