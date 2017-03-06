require 'epages/utils'

module Epages
  class WebhookResponse
    include Epages::Utils

    KEYS = %w(links content page).collect(&:to_sym).freeze

    attr_reader *KEYS

    def initialize(data)
      parse_attribute_as_array_of(:links, data.delete(:links), Epages::Link)
      parse_attribute_as_array_of(:content, data.delete(:content), Epages::Webhook)
      parse_attribute_as(:page, data.delete(:page), Epages::WebhookResponsePagination)
    end

    alias_method :webhooks, :content
  end
end
