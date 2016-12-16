require 'epages/utils'
require 'epages/rest/sales'

module Epages
  class Sales
    include Epages::Utils

    KEYS = %w(currency total_gross_revenue total_net_revenue units_sold total_orders).collect(&:to_sym).freeze

    attr_reader *KEYS

    def initialize(data)
      parse_attributes(data)
    end
  end
end
