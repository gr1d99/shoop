require 'rails_helper'

RSpec.describe "Brands", type: :request do
  before(:all) { FactoryBot.create_list(:brand, 10 ) }

  describe "GET /brands" do
    before(:each) { get brands_path }

    it 'returns status code 200' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns all brands' do
      expect(response.parsed_body.count).to eql(10)
    end
  end
end
