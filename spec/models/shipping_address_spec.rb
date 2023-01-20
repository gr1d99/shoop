# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ShippingAddress, type: :model do
  describe 'association' do
    specify { should belong_to(:user).class_name('User') }
    specify { should belong_to(:town).required }
    specify { should have_many(:orders).dependent :restrict_with_error }
  end

  describe 'validations' do
    specify { should validate_presence_of :first_name }
    specify { should validate_presence_of :last_name }
    specify { should validate_presence_of :phone }
    specify { should validate_presence_of :description }
  end
end
