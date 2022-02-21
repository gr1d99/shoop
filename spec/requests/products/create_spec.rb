require 'rails_helper'

RSpec.describe 'Products', type: :request do
  describe 'POST /products' do
    let(:product_params) { { product: {} } }
    let(:brand) { create(:brand) }
    let(:category) { create(:category) }
    let(:user) { create(:user) }

    context 'When params are valid' do
      let(:name) { 'Test Product' }
      let(:description) { 'Test Product Description' }
      let(:price) { 100.0 }

      before do
        product_params[:product] =
          { name: name, description: description, price: price, brand_id: brand.id, category_id: category.id,
            created_by: user.id }

        post products_path, params: product_params
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