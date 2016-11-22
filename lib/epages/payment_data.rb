require 'epages/utils'

module Epages
  class PaymentData
    include Epages::Utils

    KEYS = %w(payment_method price status).collect(&:to_sym).freeze

    attr_reader *KEYS

    def initialize(data)
      parse_attribute_as(:payment_method, data.delete(:paymentMethod), Epages::PaymentMethodInfo)
      parse_attribute_as(:price, data.delete(:price), Epages::Price)
    end
  end
end
