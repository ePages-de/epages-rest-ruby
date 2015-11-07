require 'epages/utils'

module Epages
  class ShippingMethod
    include Epages::Utils

    KEYS = %w(shipping_method_id name description logo).collect(&:to_sym).freeze

    attr_reader *KEYS

    def initialize(data)
      parse_attributes(data)
    end
  end
end
