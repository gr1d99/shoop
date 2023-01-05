# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'DELETE /cart_items/:id', type: :request do
  let(:user) { create :user }
  let(:cart) { create :cart, user: user }
  let(:product) { create :product }
  let(:cart_item) { create :cart_item, cart: cart, sku: product.master.sku, product: product, amount: 100, quantity: 1 }

  context 'When unauthorized' do
    before { delete cart_item_path(cart, cart_item) }

    it 'returns status code 401' do
      expect(response).to have_http_status :unauthorized
    end
  end

  context 'When authorized' do
    context 'And is not owner of cart' do
      before do
        delete cart_item_path(cart, cart_item), headers: authorization_header
      end

      it 'returns status code 404' do
        expect(response).to have_http_status :not_found
      end
    end

    context 'And is owner of cart' do
      before do
        delete cart_item_path(cart, cart_item), headers: authorization_header(user.email)
      end

      it 'returns status code 204' do
        expect(response).to have_http_status :no_content
      end
    end
  end
end
