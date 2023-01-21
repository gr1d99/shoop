# frozen_string_literal: true

class PaymentsPaymentMethod < ApplicationRecord
  self.table_name = 'payments_payment_methods'

  belongs_to :payment
  belongs_to :payment_method
end
