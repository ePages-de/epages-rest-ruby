require 'epages/utils'

module Epages
  class TaxClass
    include Epages::Utils

    KEYS = %w(tax_class_id name links).collect(&:to_sym).freeze

    attr_reader *KEYS

    def initialize(data)
      @links = data.delete(:links).collect { |i| Epages::Link.new(i) } if data[:links]
      parse_attributes(data)
    end
  end
end
