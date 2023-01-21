# frozen_string_literal: true

require 'rails_helper'

RSpec.describe County, type: :model do
  before { create :county }

  context 'Validations' do
    specify { should validate_presence_of(:name) }
    specify { should validate_uniqueness_of(:name) }
  end
end
