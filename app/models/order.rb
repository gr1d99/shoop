# frozen_string_literal: true

PAYMENT_METHODS = {
  pay_on_delivery: 'Pay on Delivery',
  card: 'Card'
}.freeze

class Order < ApplicationRecord
  include AASM

  acts_as_paranoid

  belongs_to :cart
  belongs_to :shipping_address
  has_one :orders_payment_methods, class_name: 'OrdersPaymentMethod', dependent: :destroy
  has_one :payment_method, through: :orders_payment_methods
  has_one :payment, dependent: :destroy

  has_many :items, class_name: 'OrderItem', dependent: :destroy

  validates :cart, cart_items: true, if: proc { |order| order.cart.present? }

  aasm :status do
    state :pending, initial: true
    state :payment_processing
    state :payment_confirmed
    state :order_packaging
    state :shipped
    state :in_transit
    state :out_for_delivery
    state :delivered
    state :completed
    state :cancelled
    state :hold
    state :rejected
    state :void

    event :process_payment do
      transitions from: :delivered, to: :payment_processing, guard: :payment_received?
    end

    event :confirm_payment do
      transitions from: :payment_processing, to: :payment_confirmed, guard: :payment_confirmed?
    end
  end

  private

  def cart_items
    cart.items.length
  end

  # state guards

  def pay_on_delivery?
    payment_method.name == PAYMENT_METHODS[:pay_on_delivery]
  end

  def payment_received?
    pay_on_delivery? && payment.present?
  end

  def payment_confirmed?
    false
  end
end
