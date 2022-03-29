require 'rails_helper'

module SkuHelper
  def generate_sku
    (0...8).map { (65 + rand(26)).chr }.join
  end
end

RSpec.configure do |config|
  config.include SkuHelper
end
