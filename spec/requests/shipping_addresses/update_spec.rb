# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'PUT /shipping_addresses/:id', type: :request do
  let(:shipping_address) { create :shipping_address }

  context 'When unauthorized' do
    before { put shipping_address_path(shipping_address) }

    it_behaves_like 'unauthorized request'
  end

  context 'Validations' do
    before do
      put shipping_address_path(shipping_address), params: { shipping_address: { first_name: '' } },
                                                   headers: authorization_header(shipping_address.user.email)
    end

    it_behaves_like 'unprocessable request'

    it 'returns correct errors' do
      expect(response.parsed_body['first_name']).to match_array ["can't be blank"]
    end
  end

  context 'When authorized' do
    let(:town) { create :town }
    let(:valid_params) do
      { shipping_address: {
        town_id: town.id
      } }
    end

    before do
      put shipping_address_path(shipping_address), params: valid_params,
                                                   headers: authorization_header(shipping_address.user.email)
    end

    it_behaves_like 'ok request'

    it 'returns correct fields' do
      expect(response.parsed_body['data']['attributes']['town_id']).to eql valid_params[:shipping_address][:town_id]
    end
  end
end
