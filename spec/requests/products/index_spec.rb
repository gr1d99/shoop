require 'rails_helper'

RSpec.describe 'Products', type: :request do
  before(:all) { FactoryBot.create_list(:product, 10) }

  describe 'GET /products' do
    before(:each) { get products_path }

    it 'returns status code 200' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns all products' do
      expect(response.parsed_body['data'].count).to eql(10)
    end
  end
end
