# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'POST /orders/:order_id/payments', type: :request do
  let(:user) { create :user }
  let(:cart) { create :cart, :with_items, user: user, items_count: 1 }
  let(:order) { create :order, cart: cart }
  let(:payment_method) { create :payment_method, name: 'Pay on Delivery' }

  context 'When unauthorized' do
    before { post order_payments_path(order), params: {} }

    it_should_behave_like 'unauthorized request'
  end

  context 'With pay on delivery payment method' do
    let(:cart) { create :cart, user: user }
    let(:product) { create :product, :with_master, stock: 10 }
    let(:product2) { create :product, :with_master, stock: 1 }
    let(:cart_item1) { create :cart_item, product: product, sku: product.master.sku, cart: cart }
    let(:cart_item2) { create :cart_item, product: product2, sku: product2.master.sku, cart: cart }
    let(:amount) { cart.items.select(:amount).collect(&:amount).reduce(&:+).to_f }

    before do
      cart.items << [cart_item1, cart_item2]
      order.payment_method = payment_method
      order.status = :delivered
      order.save!
      post order_payments_path(order), params: { payment: { amount: amount } },
                                       headers: authorization_header(user.email)
    end

    it_behaves_like 'created resource request'

    it 'returns payment data' do
      expect(response.parsed_body['data']['type']).to eq 'payment'
      expect(response.parsed_body['data']['attributes']['order_id']).to eql order.id
      expect(response.parsed_body['data']['attributes']['amount'].to_f).to eql amount.to_f
    end

    it 'updates order status to payment processing' do
      order.reload
      expect(order.status).to eql :payment_processing.to_s
    end
  end
end
