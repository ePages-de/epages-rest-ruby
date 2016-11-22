require 'epages/utils'

module Epages
  class MinimumCart
    include Epages::Utils

    KEYS = %w(status code amount).collect(&:to_sym).freeze

    attr_reader *KEYS

    def initialize(data)
      parse_attribute_as(:amount, data.delete(:amount), Epages::Price)
      parse_attributes(data)
    end
  end
end
