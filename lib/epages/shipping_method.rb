require 'epages/utils'

module Epages
  class ShippingMethod
    include Epages::Utils

    attr_accessor :shipping_method_id, :name, :description, :logo

    def initialize(data)
      parse_attributes(data)
    end
  end
end
