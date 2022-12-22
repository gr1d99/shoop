# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Products', type: :request do
  before(:all) { FactoryBot.create_list(:product, 10, :with_image) }

  describe 'GET /products' do
    before(:each) { get products_path }

    it 'returns status code 200' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns all products' do
      expect(response.parsed_body['data'].count).to eql(10)
    end

    context 'Pagination' do
      it 'applies page correctly' do
        get products_path, params: { page: 1, limit: 9 }

        expect(response.parsed_body['meta']['next_page']).to eq 2
      end

      it 'applies limit correctly' do
        get products_path, params: { page: 1, limit: 2 }

        expect(response.parsed_body['meta']['count']).to eq 2
      end

      it 'returns pagination data correctly' do
        get products_path, params: { page: 2, limit: 2 }

        expect(response.parsed_body['meta']['previous_page']).to eq 1
        expect(response.parsed_body['meta']['next_page']).to eq 3
        expect(response.parsed_body['meta']['total']).to eq 10
        expect(response.parsed_body['meta']['total_pages']).to eq 5
      end
    end
  end
end
