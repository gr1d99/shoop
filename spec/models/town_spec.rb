# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Town, type: :model do
  context 'Validations' do
    specify { should validate_presence_of(:name) }
  end
end
