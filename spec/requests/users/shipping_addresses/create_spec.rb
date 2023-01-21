# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'POST /users/:user_id/shipping_addresses', type: :request do
  let(:user) { create :user }
  let(:params) do
    { first_name: '',
      last_name: '',
      phone: '',
      description: '',
      town_id: '' }
  end

  context 'When unauthorized' do
    before { post user_shipping_addresses_path(user) }

    it_behaves_like 'unauthorized request'
  end

  context 'Validations' do
    before do
      post user_shipping_addresses_path(user), params: { shipping_address: params },
                                               headers: authorization_header(user.email)
    end

    it_behaves_like 'unprocessable request'

    it 'returns correct errors' do
      expect(response.parsed_body['first_name']).to match_array ["can't be blank"]
      expect(response.parsed_body['last_name']).to match_array ["can't be blank"]
      expect(response.parsed_body['phone']).to match_array ["can't be blank"]
      expect(response.parsed_body['description']).to match_array ["can't be blank"]
      expect(response.parsed_body['town']).to match_array ['must exist']
    end
  end

  context 'When authorized' do
    let(:town) { create :town }
    let(:valid_params) do
      { shipping_address: params.merge!(
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        phone: Faker::PhoneNumber.phone_number,
        description: Faker::Lorem.paragraph,
        town_id: town.id
      ) }
    end

    before { post user_shipping_addresses_path(user), params: valid_params, headers: authorization_header(user.email) }

    it_behaves_like 'created resource request'

    it 'returns correct fields' do
      expect(response.parsed_body['data']['attributes']['first_name']).to eql valid_params[:shipping_address][:first_name]
      expect(response.parsed_body['data']['attributes']['last_name']).to eql valid_params[:shipping_address][:last_name]
      expect(response.parsed_body['data']['attributes']['phone']).to eql valid_params[:shipping_address][:phone]
      expect(response.parsed_body['data']['attributes']['description']).to eql valid_params[:shipping_address][:description]
      expect(response.parsed_body['data']['attributes']['town_id']).to eql valid_params[:shipping_address][:town_id]
    end
  end
end
