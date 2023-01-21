# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Town, type: :model do
  before { create :town }

  context 'Validations' do
    specify { should validate_presence_of(:name) }
    specify { should validate_uniqueness_of(:name) }
  end
end
