# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'POST /products', type: :request do
  let(:product_params) { { product: {} } }
  let(:brand) { create(:brand) }
  let(:category) { create(:category) }
  let(:user) { create(:user) }

  context 'When params are valid' do
    let(:name) { 'Test Product' }
    let(:description) { 'Test Product Description' }
    let(:price) { 100.0 }

    before do
      product_params[:product] = {
        name: name,
        description: description,
        brand_id: brand.id,
        category_id: category.id,
        price: Faker::Commerce.price,
        sku_no: generate_sku
      }

      post products_path, params: product_params, headers: authorization_header
    end

    it 'returns status code 201' do
      expect(response).to have_http_status(:created)
    end

    it 'returns data in response body' do
      expect(response.parsed_body['data']['attributes']['name']).to eq(name)
    end
  end
end
