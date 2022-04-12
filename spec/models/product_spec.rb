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
end
