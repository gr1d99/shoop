# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'POST /cart_items', type: :request do
  let(:user) { create :user }
  let(:cart) { create :cart, user: user }

  context 'When unauthorized' do
    before { post cart_items_path(cart) }

    it_behaves_like 'unauthorized request'
  end

  context 'Availability' do
    let(:product) { create :product, :with_master, stock: 0 }
    let(:params) do
      { product_id: product.id, amount: product.price, quantity: 2, sku_id: product.master.sku_id }
    end

    context 'When out of stock' do
      before do
        post cart_items_path(cart), params: { cart_item: params }, headers: authorization_header(user.email)
      end

      it 'responds with status code 422' do
        expect(response).to have_http_status :unprocessable_entity
      end

      it_behaves_like 'unprocessable request'
    end

    context 'When quantity is more than the available stock' do
      before do
        product.master.stock = 1
        product.master.save!

        post cart_items_path(cart), params: { cart_item: params }, headers: authorization_header(user.email)
      end

      it_behaves_like 'unprocessable request'

      it 'returns quantity exceeds available stock error message' do
        expect(response.parsed_body['quantity']).to eq ['exceeds stock']
      end
    end
  end

  context 'When in product is available' do
    let(:product) { create(:product, :with_master, stock: 20) }

    let(:params) do
      { product_id: product.id, amount: product.price, quantity: 2, sku_id: product.master.sku_id }
    end

    before do
      post cart_items_path(cart), params: { cart_item: params }, headers: authorization_header(user.email)
    end

    it 'returns status code 201' do
      expect(response).to have_http_status :created
    end

    it 'adds item to cart' do
      expect(response.parsed_body['data']['attributes']['cart_id']).to eql cart.id
      expect(response.parsed_body['data']['attributes']['amount'].to_s).to eql params[:amount].to_s
      expect(response.parsed_body['data']['attributes']['quantity']).to eql params[:quantity]
      expect(response.parsed_body['data']['attributes']['option_value_id']).to be_nil
    end
  end
end
