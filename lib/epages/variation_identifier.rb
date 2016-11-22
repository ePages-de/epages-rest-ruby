require 'epages/utils'

module Epages
  class VariationIdentifier
    include Epages::Utils

    KEYS = %w(name value).collect(&:to_sym).freeze

    attr_reader *KEYS

    def initialize(data)
      parse_attributes(data)
    end
  end
end
