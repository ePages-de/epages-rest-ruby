require 'epages/utils'
require 'epages/price'

module Epages
  class PriceInfo
    include Epages::Utils

    attr_accessor :quantity, :price, :depositPrice, :ecoParticipationPrice,
                  :priceWithDeposits, :manufacturerPrice, :basePrice

    def initialize(data)
      @quantity = data.delete(:quantity)
      parse_attributes(data, Epages::Price)
    end
  end
end
