require 'rails_helper'

RSpec.describe "Brands", type: :request do
  describe "POST /brands" do
    let(:brand_params) { { brand: {} } }

    context 'When params are valid' do
      let(:brand_name) { 'Test Brand' }

      before do
        brand_params[:brand] = { name: brand_name }

        post brands_url, params: brand_params
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(:created)
      end

      it 'returns data in response body' do
        expect(response.parsed_body["name"]).to eq(brand_name)
      end
    end

    context 'When params are invalid' do
      before do
        brand_params[:brand] = { name: "" }

        post brands_url, params: brand_params
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns error message in response body' do
        expect(response.parsed_body["name"]).to include("can't be blank")
      end
    end
  end
end
