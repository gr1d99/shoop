require 'rails_helper'

RSpec.describe 'Categories', type: :request do
  describe 'POST /categories' do
    let(:category_params) { { category: {} } }

    context 'When params are valid' do
      let(:name) { 'Test Category' }

      before do
        category_params[:category] = { name: name }

        post categories_path, params: category_params
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(:created)
      end

      it 'returns data in response body' do
        expect(response.parsed_body['data']['attributes']['name']).to eq(name)
      end
    end
  end
end
