require 'epages/utils'

module Epages
  class TaxClassInfo
    include Epages::Utils

    KEYS = %w(tax_class_id name percentage).collect(&:to_sym).freeze

    attr_reader *KEYS

    def initialize(data)
      parse_attributes(data)
    end
  end
end
