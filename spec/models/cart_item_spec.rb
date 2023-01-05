# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CartItem, type: :model do
  context 'Validations' do
    let(:product) { create :product }

    before { create :cart_item, product_id: product.id, sku: product.master.sku }

    specify { should validate_presence_of(:amount) }

    specify do
      should validate_uniqueness_of(:product_id)
        .scoped_to(:cart_id, :sku_id, :deleted_at)
        .with_message('Cart item already exist')
    end
  end

  context 'Associations' do
    specify { should belong_to(:product).required }
    specify { should belong_to(:cart).required }
    specify { should belong_to(:sku).required }
  end
end
