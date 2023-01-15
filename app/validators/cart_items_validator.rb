# frozen_string_literal: true

class CartItemsValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, _)
    record.errors.add attribute, :empty if record.send(attribute).items.size.zero?
  end
end
