require 'rails_helper'

RSpec.describe CartItem, type: :model do
  context 'Validations' do
    specify { should validate_presence_of(:amount) }
  end

  context 'Associations' do
    specify { should belong_to(:product).required }
    specify { should belong_to(:cart).required }
    specify { should belong_to(:sku).required }
  end
end
