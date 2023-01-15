# frozen_string_literal: true

require 'rails_helper'

RSpec.shared_examples 'not found request' do
  it 'responds with status code 404' do
    expect(response).to have_http_status :not_found
  end
end
