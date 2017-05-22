require 'epages/utils'

module Epages
  class Webhook
    include Epages::Utils

    KEYS = %w(webhook_id active event_type callback_url created_on updated_on links).collect(&:to_sym).freeze

    attr_reader *KEYS

    def initialize(data)
      parse_attribute_as_array_of(:links, data.delete(:links), Epages::Link)
      parse_attributes(data)
    end

    alias_method :id, :webhook_id
  end
end
