# frozen_string_literal: true

class OrdersPaymentMethod < ApplicationRecord
  self.table_name = 'orders_payment_methods'

  belongs_to :order
  belongs_to :payment_method
end
