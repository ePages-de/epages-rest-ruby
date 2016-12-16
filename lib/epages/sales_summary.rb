require 'epages/utils'
require 'epages/rest/sales'

module Epages
  class SalesSummary
    include Epages::Utils

    KEYS = %w(created_after created_before sales_per_currency).collect(&:to_sym).freeze

    attr_reader *KEYS

    def initialize(data)
      parse_attribute_as_array_of(:sales_per_currency, data.delete(:sales_per_currency), Epages::Sales)
      parse_attributes(data)
    end

    alias_method :sales, :sales_per_currency
  end
end
