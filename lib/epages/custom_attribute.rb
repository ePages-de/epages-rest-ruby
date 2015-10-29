require 'epages/utils'

module Epages
  class CustomAttribute
    include Epages::Utils

    attr_accessor :key, :display_key, :single_value, :type, :values

    def initialize(data)
      parse_attributes(data)
    end

    def formatted_attributes
    	Hash[@display_key, @values.map { |v| v[:displayValue] }]
    end
  end
end
