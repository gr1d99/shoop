# frozen_string_literal: true

require 'rails_helper'

RSpec.shared_examples 'unprocessable request' do
  it 'responds with status code 422' do
    expect(response).to have_http_status :unprocessable_entity
  end
end
