# frozen_string_literal: true

class Payment < ApplicationRecord
  has_one :payments_payment_methods, class_name: 'PaymentsPaymentMethod', dependent: :destroy
  has_one :payment_method, through: :payments_payment_methods
end
