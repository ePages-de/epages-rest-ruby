require 'epages/utils'
require 'pry'

module Epages
  class Cart
    include Epages::Utils

    attr_accessor :cart_id, :billing_address, :shipping_address, :line_item_container, :min_cart_value, :checkout_url

    def initialize(data)
      parse_attribute_as(:billing_address, data.delete(:billingAddress), Epages::Address)
      parse_attribute_as(:shipping_address, data.delete(:shippingAddress), Epages::Address)
      parse_attribute_as(:line_item_container, data.delete(:lineItemContainer), Epages::LineItemContainer)
      parse_attributes(data)
    end
  end
end
