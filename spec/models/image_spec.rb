require 'rails_helper'

RSpec.describe Image, type: :model do
  context 'Validations' do
    specify { should validate_presence_of(:name) }
    specify { should validate_presence_of(:alt) }
  end

  context 'Associations' do
    specify { should belong_to(:imageable) }
  end
end
