# frozen_string_literal: true

require 'rails_helper'

RSpec.describe County, type: :model do
  context 'Validations' do
    specify { should validate_presence_of(:name) }
  end
end
