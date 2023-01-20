class ShippingAddress < ApplicationRecord
  belongs_to :county
  belongs_to :town
end
