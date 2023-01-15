# frozen_string_literal: true

require 'rails_helper'

RSpec.shared_examples 'unauthorized request' do
  it 'responds with status code 401' do
    expect(response).to have_http_status :unauthorized
  end
end
