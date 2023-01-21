# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PaymentsPaymentMethod, type: :model do
  context 'Associations' do
    specify { should belong_to(:payment) }
    specify { should belong_to(:payment_method) }
  end
end
