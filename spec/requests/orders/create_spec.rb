# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'POST /orders', type: :request do
  context 'When unauthorized' do
    it_should_behave_like 'unauthorized request'
  end

  context 'When cart is not present' do
  end

  context 'When the cart does not belong to the user' do
  end

  context 'When an item in cart is not in stock' do
  end
end
