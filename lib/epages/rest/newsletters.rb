require 'epages/rest/utils'

module Epages
  module REST
    # implements the calls in https://developer.epages.com/apps/api-reference/resource-newsletter-campaigns.html
    module Newsletters
      include REST::Utils

      # implements the call https://developer.epages.com/apps/api-reference/get-shops-shopid-newsletter-campaigns.html
      def newsletters(options = {})
        perform_get_with_key_and_objects('/newsletter-campaigns', options, :items, Epages::Newsletter)
      end

      # implements the call https://developer.epages.com/apps/api-reference/get-shops-shopid-newsletter-campaigns-campaignid-subscribers.html
      def newsletter_subscribers(newsletter, options = {})
        id = epages_id(newsletter)
        perform_get_with_key_and_objects("/newsletter-campaigns/#{id}/subscribers", options, :items, Epages::Subscriber)
      end
    end
  end
end