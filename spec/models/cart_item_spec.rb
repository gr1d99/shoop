require 'rails_helper'

RSpec.describe CartItem, type: :model do
  context 'Validations' do
    specify { should validate_presence_of(:amount) }
  end
end
