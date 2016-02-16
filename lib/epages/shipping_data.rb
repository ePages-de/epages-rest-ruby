require 'epages/utils'

module Epages
  class ShippingData
    include Epages::Utils

    KEYS = %w(shipping_method price).collect(&:to_sym).freeze

    attr_reader *KEYS

    def initialize(data)
      parse_attribute_as(:shipping_method, data.delete(:shippingMethod), Epages::ShippingMethodInfo)
      parse_attribute_as(:price, data.delete(:price), Epages::Price)
    end
  end
end
