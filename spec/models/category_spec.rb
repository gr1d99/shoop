# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'validation' do
    specify { should validate_presence_of(:name) }

    specify { should validate_uniqueness_of(:name) }
  end

  describe 'association' do
    specify { should have_many(:products) }
  end
end
