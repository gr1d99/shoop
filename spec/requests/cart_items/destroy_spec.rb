# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'DELETE /cart/:cart_id/items/:id', type: :request do
  let(:user) { create :user }
  let(:cart) { create :cart, :with_items, items_count: 2, items_stock: 10, user: user }

  context 'When unauthorized' do
    before { delete cart_item_path(cart, cart.items.first) }

    it_behaves_like 'unauthorized request'
  end

  context 'When not owner of cart' do
    before { delete cart_item_path(cart, cart.items.first), headers: authorization_header }

    it 'returns status code 404' do
      expect(response).to have_http_status :not_found
    end

    context 'And is owner of cart' do
      before { delete cart_item_path(cart, cart.items.first), headers: authorization_header(cart.user.email) }

      it 'returns status code 204' do
        expect(response).to have_http_status :no_content
      end
    end
  end
end
