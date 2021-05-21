class CategoryProduct < ApplicationRecord
  self.table_name = 'categorization'

  belongs_to :category
  belongs_to :product
end
