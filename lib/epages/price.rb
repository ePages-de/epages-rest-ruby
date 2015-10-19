require 'epages/utils'

module Epages
  class Price
    include Epages::Utils

    attr_accessor :taxType, :formatted, :amount, :currency

    def initialize(data)
      parse_attributes(data)
    end
  end
end
