# frozen_string_literal: true

require 'rails_helper'

module SkuHelper
  def generate_sku
    (0...8).map { rand(65..90).chr }.join
  end
end

RSpec.configure do |config|
  config.include SkuHelper
end
