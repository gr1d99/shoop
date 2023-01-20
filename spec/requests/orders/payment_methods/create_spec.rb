# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'POST /orders/:order_id/payment_methods', type: :request do
  let(:user) { create :user }
  let(:cart) { create :cart, :with_items, user: user, items_count: 2 }
  let(:payment_method) { create :payment_method, name: 'Pay on Delivery' }
  let(:order) { create :order, cart: cart }

  context 'When unauthorized' do
    before { post order_payment_methods_path(order) }

    it_behaves_like 'unauthorized request'
  end

  context 'With invalid params' do
    let(:params) do
      {
        order_payment_method: {
          payment_method_id: 'not-found'
        }
      }
    end

    before { post order_payment_methods_path(order), params: params, headers: authorization_header(user.email) }

    it_behaves_like 'unprocessable request'

    it 'returns error message' do
      expect(response.parsed_body['payment_method']).to match_array ['must exist']
    end
  end

  context 'With valid params' do
    let(:params) do
      {
        order_payment_method: {
          payment_method_id: payment_method.id
        }
      }
    end

    before { post order_payment_methods_path(order), params: params, headers: authorization_header(user.email) }

    it_behaves_like 'created resource request'
  end

  context ' When pay on delivery' do
    let(:params) do
      {
        order_payment_method: {
          payment_method_id: payment_method.id
        }
      }
    end

    it "transitions from 'pending' -> 'order_packaging'" do
      expect do
        post order_payment_methods_path(order), params: params, headers: authorization_header(user.email)
        order.reload
      end.to change { order.status }.from('pending').to('order_packaging')
    end
  end
end
