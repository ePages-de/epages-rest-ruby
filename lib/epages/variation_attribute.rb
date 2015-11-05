require 'epages/utils'

module Epages
  class VariationAttribute
    include Epages::Utils

    attr_accessor :name, :display_name, :values

    def initialize(data)
      parse_attributes(data)
    end

    def formatted_values
      values.collect { |el| el[:value] }
    end

    def display_values
      values.collect { |el| el[:displayValue] }
    end
  end
end
