require 'rails_helper'

RSpec.describe 'Brands', type: :request do
  before(:all) { FactoryBot.create_list(:brand, 10) }
  let(:brand) { Brand.first }

  describe 'GET /brands/:id' do
    before { get brand_path(brand.slug) }

    it 'returns status code 200' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns brand data' do
      response_body = response.parsed_body

      expect(response_body['data']['id']).to eq(brand.id.to_s)
    end

    context 'When brand does not exist' do
      before { get brand_path('22d2d') }

      it 'returns status code 404' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
