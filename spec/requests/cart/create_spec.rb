# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Cart', type: :request do
  context 'POST /cart' do
    before { post carts_path, headers: authorization_header }

    it 'returns status code 201' do
      expect(response).to have_http_status(:created)
    end

    it 'returns cart id' do
      expect(response.parsed_body['data']['id']).not_to be_nil

    end

    it 'returns user id' do
      expect(response.parsed_body['data']['relationships']['user']).not_to be_nil
      expect(response.parsed_body['data']['attributes']['user_id']).not_to be_nil
    end

    context 'When cart exists' do
      let(:current_cart) { create(:cart) }
      let(:current_user) { create(:user) }

      before do
        current_cart.update(user: current_user)
        post carts_path, headers: authorization_header(current_user.email)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns current cart' do
        expect(response.parsed_body['data']['id']).to eq current_cart.id.to_s
      end
    end

    context 'When cart doesn\'t exists' do
      let(:current_cart) { create(:cart) }
      let(:current_user) { create(:user) }

      before do
        post carts_path, headers: authorization_header(current_user.email)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(:created)
      end

      it 'returns new cart' do
        expect(response.parsed_body['data']['id']).not_to eq current_cart.id.to_s
      end
    end
  end
end
