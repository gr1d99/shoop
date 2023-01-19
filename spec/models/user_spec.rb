# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validation' do
    specify { should validate_presence_of(:first_name) }

    specify { should validate_presence_of(:last_name) }

    specify { should validate_presence_of(:email) }

    specify { should validate_uniqueness_of(:email) }

    specify {  should validate_presence_of(:phone) }

    specify {  should validate_uniqueness_of(:phone) }

    specify { should validate_presence_of(:password) }
  end

  describe 'associations' do
    specify { should have_many(:products).dependent(:destroy) }
  end

  describe '#orders' do
    let(:user) { create :user }
    let(:cart) { create :cart, :with_items, items_count: 1, user: user }
    let(:payment_method) { create :payment_method, :pay_on_delivery }
    let(:order) { create :order, cart: cart }

    before do
      user.carts << cart
      order.cart = cart
      order.payment_method = payment_method
      order.save!
    end

    it 'returns associated order' do
      expect(user.orders.size).to eq 1
    end

    it 'returns a chainable relation' do
      expect(user.orders).to be_a ActiveRecord::Relation
    end
  end
end
