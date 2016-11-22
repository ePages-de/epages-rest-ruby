require 'epages/utils'

module Epages
  class DeliveryWeightQuantity
    include Epages::Utils

    KEYS = %w(amount unit).collect(&:to_sym).freeze

    attr_reader *KEYS

    def initialize(data)
      parse_attributes(data)
    end
  end
end
