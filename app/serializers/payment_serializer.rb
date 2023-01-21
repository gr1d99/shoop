# frozen_string_literal: true

class PaymentSerializer
  include JSONAPI::Serializer

  attributes :amount, :order_id

  has_one :payment_method
end
