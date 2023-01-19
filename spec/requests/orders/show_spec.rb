# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GET /orders/:id', type: :request do
  let(:user) { create :user }
  let(:cart) { create :cart, :with_items, user: user, items_count: 2 }
  let(:payment_method) { create :payment_method, name: 'Pay on Delivery' }
  let(:order) { create :order, cart: cart, payment_method: payment_method }

  context 'When unauthorized' do
    before { get order_path(order) }

    it_should_behave_like 'unauthorized request'
  end

  context 'When order is not present' do
    before { get order_path('not-found'), headers: authorization_header(user.email) }

    it_behaves_like 'not found request'
  end

  context 'When the order does not belong to the user' do
    let(:guest) { create :user }

    before { get order_path(order), headers: authorization_header(guest.email) }

    it_behaves_like 'not found request'
  end

  context 'When order exist' do
    before { get order_path(order), headers: authorization_header(user.email) }

    it_behaves_like 'ok request'

    it 'returns order data' do
      expect(response.parsed_body['data']['type']).to eq 'order'
      expect(response.parsed_body['data']['id']).to eq order.id.to_s
      expect(response.parsed_body['data']['attributes']['cart_id']).to eq cart.id
      expect(response.parsed_body['data']['relationships']['items'].size).to eql 1
    end
  end
end
