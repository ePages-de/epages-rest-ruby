require 'epages/utils'

module Epages
  class BasePrice
    include Epages::Utils

    KEYS = %w(ref_quantity ref_price formatted quantity).collect(&:to_sym).freeze

    attr_reader *KEYS

    def initialize(data)
      parse_attribute_as(:ref_price, data.delete(:refPrice), Epages::Price)
      parse_attributes(data)
    end
  end
end
