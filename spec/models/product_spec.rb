# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'validation' do
    specify { should validate_presence_of(:name) }

    specify { should validate_presence_of(:description) }
  end

  describe 'association' do
    specify { should belong_to(:created_by).class_name('User') }

    specify { should belong_to(:brand).required }

    specify { should belong_to(:category).required }
  end

  context 'Pricing' do
    let(:product) { create(:product) }

    it 'sets default price from master variant' do
      expect(product.price).not_to be_nil
      expect(product.price).to eql(product.master.price)
    end
  end
end
