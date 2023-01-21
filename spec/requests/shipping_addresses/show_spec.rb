# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GET /shipping_addresses/:id', type: :request do
  let(:shipping_address) { create :shipping_address }

  context 'When unauthorized' do
    before { get shipping_address_path(shipping_address) }

    it_behaves_like 'unauthorized request'
  end
  before { get shipping_address_path(shipping_address), headers: authorization_header(shipping_address.user.email) }

  it_behaves_like 'ok request'

  it 'returns correct fields' do
    expect(response.parsed_body['data']['id']).to eql shipping_address.id.to_s
    expect(response.parsed_body['data']['attributes']['town_id']).to eql shipping_address.town_id
  end
end
