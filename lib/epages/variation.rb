require 'epages/utils'

module Epages
  class Variation
    include Epages::Utils

    def initialize(data)
      parse_attributes(data)
    end

    def link
      @link[:href]
    end

    def product_id
      link.split('/').last
    end

    def properties
      Hash[@attribute_selection.collect { |el| [el[:name].downcase.to_sym, el[:value]] }]
    end

    alias_method :attributes, :properties
  end
end
