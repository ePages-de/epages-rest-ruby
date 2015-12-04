require 'epages/utils'

module Epages
  class CustomAttribute
    include Epages::Utils

    KEYS = %w(key display_key single_value type values).collect(&:to_sym).freeze

    attr_reader *KEYS

    def initialize(data)
      parse_attributes(data)
    end

    # return a Hash with the display value as key and an array with all the displayValue as value
    def formatted_attributes
      Hash[display_key.downcase.to_sym, values.collect { |el| el[:displayValue] }]
    end
  end
end
