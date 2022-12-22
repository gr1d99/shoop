# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'POST /users' do
    let(:user_params) { {} }

    context 'When params are valid' do
      let(:params) { attributes_for(:user) }

      before do
        user_params[:user] = params

        post users_url, params: user_params
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(:created)
      end

      # it 'returns data in response body' do
      #   expect(response.parsed_body["name"]).to eq(brand_name)
      # end
    end

    # context 'When params are invalid' do
    #   before do
    #     brand_params[:brand] = { name: "" }
    #
    #     post brands_url, params: brand_params
    #   end
    #
    #   it 'returns status code 422' do
    #     expect(response).to have_http_status(:unprocessable_entity)
    #   end
    #
    #   it 'returns error message in response body' do
    #     expect(response.parsed_body["name"]).to include("can't be blank")
    #   end
    # end
  end
end
