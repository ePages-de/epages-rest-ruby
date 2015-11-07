require 'epages/utils'

module Epages
  class CustomAttribute
    include Epages::Utils

    KEYS = %w(key display_key single_value type values).collect(&:to_sym).freeze

    attr_reader *KEYS

    def initialize(data)
      parse_attributes(data)
    end

    def formatted_attributes
      Hash[display_key, values.collect { |v| v[:displayValue] }]
    end
  end
end
