require 'rails_helper'

RSpec.describe Brand, type: :model do
  let(:b) { FactoryBot.create(:brand_with_products) }

  describe 'validation' do
    before { FactoryBot.create(:brand) }

    specify do
      should validate_presence_of(:name)
    end

    specify { should validate_uniqueness_of(:name) }
  end

  describe 'association' do
    specify { should have_many(:products) }
  end
end
