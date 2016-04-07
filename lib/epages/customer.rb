require 'epages/utils'

module Epages
  class Customer
    include Epages::Utils

    KEYS = %w(customer_id customer_number creation_date billing_address internal_note links).collect(&:to_sym).freeze

    attr_reader *KEYS

    def initialize(data)
      parse_attribute_as(:billing_address, data.delete(:billingAddress), Epages::Address)
      parse_attribute_as_array_of(:links, data.delete(:links), Epages::Link)
      parse_attribute_as(:creation_date, data.delete(:creationDate), DateTime)
      parse_attributes(data)
    end

    alias_method :id, :customer_id
  end
end
