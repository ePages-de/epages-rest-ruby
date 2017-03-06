require 'epages/utils'

module Epages
  class WebhookResponsePagination
    include Epages::Utils

    KEYS = %w(size total_elements total_pages number).collect(&:to_sym).freeze

    attr_reader *KEYS

    def initialize(data)
      parse_attributes(data)
    end
  end
end
