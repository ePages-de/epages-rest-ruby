require 'epages/utils'

module Epages
  class Price
    include Epages::Utils

    KEYS = %w(tax_type formatted amount currency).collect(&:to_sym).freeze

    attr_reader *KEYS

    def initialize(data)
      parse_attributes(data)
    end
  end
end
