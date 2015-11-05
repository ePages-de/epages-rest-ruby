require 'epages/utils'

module Epages
  class LineItemContainer
    include Epages::Utils

    attr_accessor :grand_total, :total_before_tax, :total_tax, :line_items_sub_total,
                  :product_line_items, :shipping_price

    def initialize(data)
      parse_attribute_as(:grand_total, data[:grandTotal], Epages::Price)
      parse_attribute_as(:total_before_tax, data[:totalBeforeTax], Epages::Price)
      parse_attribute_as(:total_tax, data[:totalTax], Epages::Price)
      parse_attribute_as(:line_items_sub_total, data[:lineItemsSubTotal], Epages::Price)
      parse_attribute_as_array_of(:product_line_items, data[:productLineItems], Epages::ProductLineItem)
    end
  end
end
