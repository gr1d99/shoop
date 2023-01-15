# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/GET /cart/:id/items', type: :request do
  let(:current_user) { create :user, email: 'current@mail.com' }
  let(:cart) { create(:cart, :with_items, items_count: 2, items_stock: 2, user: current_user) }

  context 'When unauthorized' do
    before { get cart_items_path(cart) }

    it 'responds with status code 401' do
      expect(response).to have_http_status :unauthorized
    end
  end

  context 'When current user is not owner of cart' do
    before { get cart_items_path(cart), headers: authorization_header }

    it 'responds with 404' do
      expect(response).to have_http_status :not_found
    end
  end

  it 'returns cart items' do
  end
end
