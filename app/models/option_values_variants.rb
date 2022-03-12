class OptionValuesVariants < ApplicationRecord
  belongs_to :option_value
  belongs_to :variant
end
