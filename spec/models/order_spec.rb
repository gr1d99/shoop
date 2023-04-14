# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:user) { create :user }
  let(:cart) { create :cart, :with_items, items_count: 1 }

  subject do
    create :order, cart: cart
  end

  context 'Associations' do
    specify { should have_one(:payment_method).through :orders_payment_methods }
    specify { should have_one(:payment) }
    specify { should belong_to(:shipping_address) }
  end
end
