# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validation' do
    specify { should validate_presence_of(:first_name) }

    specify { should validate_presence_of(:last_name) }

    specify { should validate_presence_of(:email) }

    specify { should validate_uniqueness_of(:email) }

    specify {  should validate_presence_of(:phone) }

    specify {  should validate_uniqueness_of(:phone) }

    specify { should validate_presence_of(:password) }
  end

  describe 'associations' do
    specify { should have_many(:products).dependent(:destroy) }
  end
end
