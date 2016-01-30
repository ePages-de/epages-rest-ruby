require 'epages/utils'

module Epages
  class Variation
    include Epages::Utils

    attr_reader :link, :attribute_selection

    def initialize(data)
      parse_attributes(data)
    end

    # returns the url of the variation
    def url
      link.href
    end

    # returns the product_id of the variation
    def product_id
      url.split('/').last
    end

    # returns a hash formatting the property and the respective value as a pair of the hash
    def properties
      Hash[attribute_selection.collect { |el| [el[:name].downcase.to_sym, el[:value]] }]
    end

    alias_method :attributes, :properties
    alias_method :id, :product_id
  end
end
