# frozen_string_literal: true

class InStockValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    stock = record.sku.variant.stock

    record.errors.add :product, :out_of_stock if stock.zero?

    return unless value > stock

    record.errors.add attribute, :quantity_unavailable
  end
end
