require 'epages/utils'

module Epages
  class Newsletter
    include Epages::Utils

    KEYS = %w(campaign_id language identifier name description number_of_subscribers subject).collect(&:to_sym).freeze

    attr_reader *KEYS

    def initialize(data)
      parse_attributes(data)
    end

    alias_method :id, :campaign_id
  end
end
