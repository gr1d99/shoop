# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Carts', type: :request do
  before(:all) { FactoryBot.create_list(:cart, 10) }

  describe 'GET /carts' do
    context 'When unauthenticated' do
      before { get carts_path }

      it 'returns status code 401' do
        expect(response).to have_http_status :unauthorized
      end
    end

    before(:all) { get carts_path, headers: authorization_header }

    it 'returns status code 200' do
      expect(response).to have_http_status :ok
    end

    it 'returns all carts' do
      expect(response.parsed_body['data'].count).to eql 10
      expect(response.parsed_body['meta']['total']).to eql 10
    end
  end
end
