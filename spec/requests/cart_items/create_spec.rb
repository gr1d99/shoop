# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'POST /cart_items', type: :request do
  let(:user) { create :user }
  let(:cart) { create :cart, user: user }

  context 'When unauthorized' do
    before { post cart_items_path(cart) }

    it 'returns status code 401' do
      expect(response).to have_http_status :unauthorized
    end
  end

  context 'Without variants' do
    let(:product) { create(:product, :with_master) }

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

  context 'With variant' do
    let(:option) { create :option, name: 'Color' }
    let(:option_value) { create :option_value, name: 'Red', option: option }
    let(:product_with_variant) { create(:product, :with_variant, variant_option_values: [option_value]) }
    let(:params) do
      { product_id: product_with_variant.id, amount: product_with_variant.variants.first.price, quantity: 2,
        sku_id: product_with_variant.variants.first.sku_id }
    end

    before do
      post cart_items_path(cart), params: { cart_item: params }, headers: authorization_header(user.email)
    end

    it 'returns status code 201' do
      expect(response).to have_http_status :created
    end

    it 'adds item to cart with variant' do
      expect(response.parsed_body['data']['attributes']['cart_id']).to eql cart.id
      expect(response.parsed_body['data']['attributes']['amount'].to_f).to eql params[:amount].to_f
      expect(response.parsed_body['data']['attributes']['quantity']).to eql params[:quantity]
      expect(response.parsed_body['data']['attributes']['sku_id'].to_s).to eql params[:sku_id].to_s
    end
  end
end
