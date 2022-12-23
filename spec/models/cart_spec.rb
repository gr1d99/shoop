require 'rails_helper'

RSpec.describe Cart, type: :model do
  describe 'association' do
    specify { should have_many(:items).class_name('CartItem').dependent(:destroy) }
    specify { should belong_to(:user).required }
  end
end
