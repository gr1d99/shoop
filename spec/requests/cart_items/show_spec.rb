# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GET /cart_items/:id', type: :request do
  let(:user) { create :user }
  let(:cart) { create :cart, user: user }
  let(:product) { create :product }
  let(:cart_item) { create :cart_item, cart: cart, sku: product.master.sku, product: product, amount: 100, quantity: 1 }

  context 'When unauthorized' do
    before { get cart_item_path(cart, cart_item) }

    it 'returns status code 401' do
      expect(response).to have_http_status :unauthorized
    end
  end

  context 'When authorized' do
    context 'And is not owner of cart' do
      before do
        get cart_item_path(cart, cart_item), headers: authorization_header
      end

      it 'returns status code 404' do
        expect(response).to have_http_status :not_found
      end
    end

    context 'And is owner of cart' do
      before do
        get cart_item_path(cart, cart_item), headers: authorization_header(user.email)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status :ok
      end

      it 'returns cart_item details' do
        data = response.parsed_body['data']

        expect(data['id']).to eql cart_item.id.to_s
        expect(data['attributes']['product_id']).to eql product.id.to_i
        expect(data['attributes']['sku_id']).to eql product.master.sku.id.to_i
        expect(data['attributes']['cart_id']).to eql cart.id.to_i
        expect(data['attributes']['amount']).to eql 100.to_f.to_s
        expect(data['attributes']['quantity']).to eql 1
      end
    end
  end
end
