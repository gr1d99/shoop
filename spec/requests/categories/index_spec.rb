# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Categories', type: :request do
  before(:all) { FactoryBot.create_list(:category, 10) }

  describe 'GET /categories' do
    before(:each) { get categories_path }

    it 'returns status code 200' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns all categories' do
      expect(response.parsed_body['data'].count).to eql(10)
    end
  end
end
