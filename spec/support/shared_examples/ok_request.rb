# frozen_string_literal: true

require 'rails_helper'

RSpec.shared_examples 'ok request' do
  it 'responds with status code 200' do
    expect(response).to have_http_status :ok
  end
end
