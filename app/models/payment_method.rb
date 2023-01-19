# frozen_string_literal: true

class PaymentMethod < ApplicationRecord
  has_many :orders_payment_methods
  has_many :orders, through: :orders_payment_methods
end
