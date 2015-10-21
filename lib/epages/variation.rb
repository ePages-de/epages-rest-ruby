require 'epages/utils'

module Epages
  class Variation
    include Epages::Utils

    attr_accessor :name, :display_name

    def initialize(data)
      parse_attributes(data)
    end

    def values
      @values.collect { |el| el[:value] }
    end

    def display_values
      @values.collect { |el| el[:displayValue] }
    end
  end
end
