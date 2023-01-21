# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GET users/:user_id/shipping_addresses', type: :request do
  let(:shipping_address) { create :shipping_address }

  context 'When unauthorized' do
    before { get user_shipping_addresses_path(shipping_address) }

    it_behaves_like 'unauthorized request'
  end
  before do
    get user_shipping_addresses_path(shipping_address), headers: authorization_header(shipping_address.user.email)
  end

  it_behaves_like 'ok request'

  it 'returns correct fields' do
    expect(response.parsed_body['meta']['total_pages']).to eql 1
    expect(response.parsed_body['data'][0]['attributes']['town_id']).to eql shipping_address.town_id
    expect(response.parsed_body['data'][0]['attributes']['user_id']).to eql shipping_address.user_id
  end
end
