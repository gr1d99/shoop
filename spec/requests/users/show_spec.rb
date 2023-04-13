# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  before(:all) { FactoryBot.create_list(:user, 2) }
  let(:user) { User.first }

  describe 'GET /users/:id' do
    it 'returns status code 200' do
      get user_path(user.id), headers: authorization_header(user.email)

      expect(response).to have_http_status(:ok)
    end

    it 'returns user data' do
      get user_path(user.id), headers: authorization_header(user.email)

      response_body = response.parsed_body

      expect(response_body['data']['id']).to eq(user.id.to_s)
    end

    context 'When user does not exist' do
      before { get user_path('22d2d'), headers: authorization_header(user.email) }

      it 'returns status code 404' do
        p response.parsed_body
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
