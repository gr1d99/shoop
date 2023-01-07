# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Variant, type: :model do
  let(:product) { create :product }
  let(:subject) { create :variant, product: product }

  context 'Validations' do
    specify { should validate_numericality_of(:stock) }
  end
end
