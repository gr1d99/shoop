# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GET /sku', type: :request do
  before do
    create_list :sku, 2
  end

  before do
    get sku_index_path
  end

  it 'responds with status code 200' do
    expect(response).to have_http_status :ok
  end

  it 'returns correct skus data' do
    expect(response.parsed_body['meta']['total']).to eq 2
  end
end
