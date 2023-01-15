# frozen_string_literal: true

require 'rails_helper'

RSpec.shared_examples 'created resource request' do
  it 'responds with status code 201' do
    expect(response).to have_http_status :created
  end
end
