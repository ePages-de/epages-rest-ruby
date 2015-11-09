require 'epages/utils'
require 'epages/price'

module Epages
  class PriceInfo
    include Epages::Utils

    KEYS = %w(quantity price deposit_price eco_participation_price price_with_deposits manufacturer_price base_price).collect(&:to_sym).freeze

    attr_reader *KEYS

    def initialize(data)
      parse_attribute_as(:quantity, data.delete(:quantity))
      parse_attribute_as(:base_price, data.delete(:basePrice), Epages::BasePrice)
      parse_attributes(data, Epages::Price)
    end
  end
end
