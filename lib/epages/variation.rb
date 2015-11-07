require 'epages/utils'

module Epages
  class Variation
    include Epages::Utils

    attr_reader :link, :attribute_selection

    def initialize(data)
      parse_attributes(data)
    end

    # returns the link of the variation
    def link
      @link[:href]
    end

    # returns the product_id of the variation
    def product_id
      link.split('/').last
    end

    # returns a hash formatting the property and the respective value as a pair of the hash
    def properties
      Hash[attribute_selection.collect { |el| [el[:name].downcase.to_sym, el[:value]] }]
    end

    alias_method :attributes, :properties
  end
end
