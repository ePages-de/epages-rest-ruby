require 'epages/utils'

module Epages
  class PaymentMethodInfo
    include Epages::Utils

    KEYS = %w(id name).collect(&:to_sym).freeze

    attr_reader *KEYS

    def initialize(data)
      parse_attributes(data)
    end
  end
end
