require 'epages/utils'
require 'epages/error'

module Epages
  class OrdersResponse
    include Epages::Utils

    KEYS = %w(results page resultsPerPage items).collect(&:to_sym).freeze

    attr_reader *KEYS

    def initialize(data)
      parse_attribute_as_array_of(:items, data.delete(:items), Epages::Order)
      parse_attributes(data)
    end

    alias_method :orders, :items
  end
end
