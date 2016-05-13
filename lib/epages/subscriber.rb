require 'epages/utils'

module Epages
  class Subscriber
    include Epages::Utils

    KEYS = %w(email name subscribed).collect(&:to_sym).freeze

    attr_reader *KEYS

    def initialize(data)
      parse_attributes(data)
    end
  end
end
