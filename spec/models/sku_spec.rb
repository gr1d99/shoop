# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Sku, type: :model do
  context 'Associations' do
    specify { should have_one :variant }
  end

  context 'Validations' do
    before { FactoryBot.create(:sku) }

    specify { should validate_presence_of(:sku_no) }
    specify { should validate_uniqueness_of(:sku_no) }
  end
end
