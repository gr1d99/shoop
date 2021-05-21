require 'rails_helper'

RSpec.describe CategoryProduct, type: :model do
  describe 'association' do
    specify { should belong_to(:category) }
    specify { should belong_to(:product) }
  end
end
