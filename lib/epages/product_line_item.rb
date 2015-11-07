require 'epages/utils'

module Epages
  class ProductLineItem
    include Epages::Utils

    KEYS = %w(line_item_id sku name product_id quantity line_item_price single_item_price images links).collect(&:to_sym).freeze

    attr_reader *KEYS

    def initialize(data)
      parse_attribute_as_array_of(:images, data.delete(:images), Epages::Image)
      parse_attribute_as_array_of(:links, data.delete(:links), Epages::Link)
      parse_attribute_as(:quantity, data.delete(:quantity))
      parse_attribute_as(:line_item_price, data.delete(:lineItemPrice), Epages::Price)
      parse_attribute_as(:single_item_price, data.delete(:singleItemPrice), Epages::Price)
      parse_attributes(data)
    end
  end
end
