require 'epages/utils'
require 'epages/price'

module Epages
  class PriceInfo
    include Epages::Utils

    attr_accessor :quantity, :price, :deposit_price, :eco_participation_price,
                  :price_with_deposits, :manufacturer_price, :base_price

    def initialize(data)
      @quantity = data.delete(:quantity)
      parse_attributes(data, Epages::Price)
    end
  end
end
