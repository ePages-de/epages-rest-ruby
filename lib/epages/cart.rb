require 'epages/utils'

module Epages
  class Cart
    include Epages::Utils

    KEYS = %w(cart_id billing_address shipping_address line_item_container minimum_cart checkout_url tax_class_id).collect(&:to_sym).freeze

    attr_reader *KEYS

    def initialize(data)
      parse_attribute_as(:billing_address, data.delete(:billingAddress), Epages::Address)
      parse_attribute_as(:shipping_address, data.delete(:shippingAddress), Epages::Address)
      parse_attribute_as(:line_item_container, data.delete(:lineItemContainer), Epages::LineItemContainer)
      parse_attribute_as(:minimum_cart, data.delete(:minimumCart), Epages::MinimumCart)
      parse_attributes(data)
    end

    alias_method :id, :cart_id
  end
end
