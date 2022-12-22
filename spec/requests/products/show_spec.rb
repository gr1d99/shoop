# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Products', type: :request do
  before(:all) { FactoryBot.create_list(:product, 10) }
  let(:product) { Product.first }

  describe 'GET /products/:id' do
    before { get product_path(product.slug) }

    it 'returns status code 200' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns product data' do
      response_body = response.parsed_body

      expect(response_body['data']['id']).to eq(product.id.to_s)
    end

    context 'When product does not exist' do
      before { get product_path('22d2d') }

      it 'returns status code 404' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
