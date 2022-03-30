# frozen_string_literal: true

class OptionValuesVariants < ApplicationRecord
  belongs_to :option_value
  belongs_to :variant
end
