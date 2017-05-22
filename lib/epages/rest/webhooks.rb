require 'epages/utils'
require 'epages/rest/utils'

module Epages
  module REST
    module Webhooks
      include REST::Utils

      def webhook(webhook_id, options = {})
        perform_get_with_object("/webhooks/#{webhook_id}", options, Epages::Webhook)
      end

      def create_webhook(callback_url, event_type)
        available_events = ["PRODUCT_CREATE", "PRODUCT_UPDATE", "PRODUCT_DELETE", "ORDER_CREATE", "ORDER_UPDATE", "ORDER_DELETE", "APP_UNINSTALL"]
        return 'Invalid event' unless (available_events.include? event_type)
        perform_post_with_object("/webhooks",
                                 { 'callbackUrl': callback_url, 'eventType': event_type },
                                 Epages::Webhook)
      end

      def activate_webhook(webhook_id)
        perform_post_with_object("/webhooks/#{webhook_id}", { 'active': 'true' }, Epages::Webhook)
      end

      def deactivate_webhook(webhook_id)
        perform_post_with_object("/webhooks/#{webhook_id}", { 'active': 'false' }, Epages::Webhook)
      end

      def delete_webhook(webhook_id, options = {})
        answer = perform_delete_request("/webhooks/#{webhook_id}", options)
        return answer.nil? ? 'Deleted' : 'Error'
      end
    end
  end
end
