require 'epages/utils'

module Epages
  class ShippingMethodInfo
    include Epages::Utils

    KEYS = %w(id name).collect(&:to_sym).freeze

    attr_reader *KEYS

    def initialize(data)
      parse_attributes(data)
    end
  end
end
