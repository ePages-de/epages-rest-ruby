require 'epages/utils'
require 'epages/error'

module Epages
  class ProductsResponse
    include Epages::Utils

    KEYS = %w(results page results_per_page items).collect(&:to_sym).freeze

    attr_reader *KEYS

    def initialize(data)
      parse_attribute_as_array_of(:items, data.delete(:items), Epages::Product)
      parse_attributes(data)
    end

    alias_method :products, :items
  end
end
