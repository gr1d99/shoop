# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'POST /orders', type: :request do
  let(:user) { create :user }
  let(:cart) { create :cart, user: user }

  context 'When unauthorized' do
    before { post cart_orders_path(cart), params: {} }

    it_should_behave_like 'unauthorized request'
  end

  context 'When cart is not present' do
    before { post cart_orders_path('not-found'), params: {}, headers: authorization_header(user.email) }

    it_behaves_like 'not found request'
  end

  context 'When the cart does not belong to the user' do
    let(:guest) { create :user }

    before { post cart_orders_path(cart), params: {}, headers: authorization_header(guest.email) }

    it_behaves_like 'not found request'
  end

  context 'When cart has no items' do
    before { post cart_orders_path(cart), params: {}, headers: authorization_header(user.email) }

    it_behaves_like 'unprocessable request'
  end

  context 'With correct cart' do
    let(:cart) { create :cart, user: user }
    let(:product) { create :product, :with_master, stock: 10 }
    let(:cart_item) { create :cart_item, product: product, sku: product.master.sku, cart: cart }

    before do
      cart.items << cart_item

      post cart_orders_path(cart), params: {}, headers: authorization_header(user.email)
    end

    it_behaves_like 'created resource request'

    it 'returns cart data' do
      expect(response.parsed_body['data']['type']).to eq 'order'
      expect(response.parsed_body['data']['attributes']['cart_id']).to eq cart.id
      expect(response.parsed_body['data']['relationships']['items'].size).to eq cart.items.size
    end
  end
end
