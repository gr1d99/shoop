# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Carts /carts/:id', type: :request do
  let(:user) { create(:user) }
  let(:cart) { Cart.first }

  before(:all) { create_list(:cart, 10) }

  describe 'GET /carts/:id' do
    context 'When unauthenticated' do
      before { get cart_path(cart.id) }

      it 'returns status code 401' do
        expect(response).to have_http_status :unauthorized
      end
    end

    context 'When authenticated' do
      before do
        Cart.find_in_batches(batch_size: 5) do |carts|
          carts.each { |cart| cart.update(user: user) }
        end
      end

      before { get cart_path(cart.id), headers: authorization_header(user.email) }

      it 'returns status code 200' do
        expect(response).to have_http_status :ok
      end

      it 'returns cart' do
        expect(response.parsed_body['data']['id']).to eql cart.id.to_s
      end
    end
  end
end
