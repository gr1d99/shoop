# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Order, type: :model do
  context 'Associations' do
    specify { should have_one(:payment_method).through :orders_payment_methods }
  end
end
