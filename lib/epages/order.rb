require 'epages/utils'
require 'epages/error'

module Epages
  class Order
    include Epages::Utils

    DATE_ATTRS = %w(creation_date invoiced_on delivered_on pending_on archived_on dispatched_on viewed_on
                    rejected_on closed_on paid_on returned_on)

    ATTRS = %w(order_id order_number billing_address shipping_address customer_id locale currency_id tax_model
               grand_total total_before_tax line_item_container product_line_items shipping_price links internal_note
               customer_comment customer_number shipping_data payment_data)

    KEYS = (ATTRS + DATE_ATTRS).collect(&:to_sym).freeze

    attr_reader *KEYS

    def initialize(data)
      DATE_ATTRS.each { |i| parse_attribute_as(i.to_sym, data.delete(i.camelize(:lower).to_sym), DateTime) }
      parse_attribute_as_array_of(:links, data.delete(:links), Epages::Link)
      parse_attribute_as_array_of(:product_line_items, data.delete(:productLineItems), Epages::ProductLineItem)
      parse_attribute_as(:shipping_price, data.delete(:shippingPrice), Epages::Price)
      parse_attribute_as(:billing_address, data.delete(:billingAddress), Epages::Address)
      parse_attribute_as(:shipping_address, data.delete(:shippingAddress), Epages::Address)
      parse_attribute_as(:line_item_container, data.delete(:lineItemContainer), Epages::LineItemContainer)
      parse_attribute_as(:shipping_data, data.delete(:shippingData), Epages::ShippingData)
      parse_attribute_as(:payment_data, data.delete(:paymentData), Epages::PaymentData)
      parse_attributes(data)
    end

    alias_method :id, :order_id
  end
end
