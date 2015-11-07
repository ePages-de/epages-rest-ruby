require 'epages/utils'

module Epages
  class VariationAttribute
    include Epages::Utils

    attr_accessor :name, :display_name, :values

    def initialize(data)
      parse_attributes(data)
    end

    # returns an array with all the values
    def formatted_values
      values.collect { |el| el[:value] }
    end

    # returns an array with all the display_values
    def display_values
      values.collect { |el| el[:displayValue] }
    end
  end
end
