# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'POST /sku', type: :request do
  let(:params) { { sku: {} } }

  it_behaves_like 'unauthorized request' do
    before { post sku_index_path, params: params }
  end

  context 'when params are invalid' do
    let(:invalid_params) { params.merge(sku: { value: '' }) }

    before { post sku_index_path, params: invalid_params, headers: authorization_header }

    it_behaves_like 'unprocessable request'

    it 'returns correct error' do
      expect(response.parsed_body['value']).to eq ["can't be blank"]
    end

    context 'With duplicate value' do
      let(:sku) { create :sku }
      let(:invalid_params) { params.merge(sku: { value: sku.value }) }

      before do
        post sku_index_path, params: invalid_params, headers: authorization_header
      end

      it 'returns value taken error' do
        expect(response.parsed_body['value']).to eq ['has already been taken']
      end
    end
  end

  context 'With valid params' do
    let(:valid_params) { params.merge(sku: { value: Faker::Name.unique(5).name }) }

    before { post sku_index_path, params: valid_params, headers: authorization_header }

    it_behaves_like 'created resource request'
  end
end
