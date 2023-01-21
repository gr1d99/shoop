# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Payment, type: :model do
  context 'Associations' do
    specify { should have_one(:payment_method).through :payments_payment_methods }
  end
end
