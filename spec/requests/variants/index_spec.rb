# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GET /variants', type: :request do
  let(:products) { create_list :product, 2 }
  before do
    products.each { |product| create :variant, product: product }
  end

  context 'When data exist' do
    before do
      get variants_path
    end

    it 'returns status code 200' do
      expect(response).to have_http_status :ok
    end

    it 'lists all variants' do
      expect(response.parsed_body['meta']['total']).to eq 2
    end
  end
end
