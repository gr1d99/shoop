# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'PUT /cart_items/:id', type: :request do
  let(:user) { create :user }
  let(:cart) { create :cart, user: user }
  let(:product) { create :product, :with_master }
  let(:cart_item) { create :cart_item, cart: cart, sku: product.master.sku, product: product, amount: 100, quantity: 1 }

  context 'When unauthorized' do
    before { put cart_item_path(cart, cart_item) }

    it 'returns status code 401' do
      expect(response).to have_http_status :unauthorized
    end
  end

  context 'When authorized' do
    let(:params) do
      { amount: 100, quantity: 2, sku_id: product.master.sku_id }
    end

    context 'And is not owner of cart' do
      before do
        put cart_item_path(cart, cart_item), params: { cart_item: params }, headers: authorization_header
      end

      it 'returns status code 404' do
        expect(response).to have_http_status :not_found
      end
    end

    context 'And is owner of cart' do
      before do
        put cart_item_path(cart, cart_item), params: { cart_item: params }, headers: authorization_header(user.email)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status :ok
      end
    end
  end
end
