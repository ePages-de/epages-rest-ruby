require 'epages/utils'

module Epages
  class Price
    include Epages::Utils

    attr_accessor :tax_type, :formatted, :amount, :currency

    def initialize(data)
      parse_attributes(data)
    end
  end
end
