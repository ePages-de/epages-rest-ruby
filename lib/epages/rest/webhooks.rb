require 'epages/utils'
require 'epages/rest/utils'

module Epages
  module REST
    module Webhooks
      include REST::Utils

      def webhooks(options = {})
        perform_get_with_object("/webhooks", options, Epages::WebhookResponse)
      end

      def webhook(webhook_id, options = {})
        perform_get_with_object("/webhooks/#{webhook_id}", options, Epages::Webhook)
      end

      def create_webhook(webhook_id, event_type)
        available_events = ["PRODUCT_CREATE", "PRODUCT_UPDATE", "PRODUCT_DELETE", "ORDER_CREATE", "ORDER_UPDATE", "ORDER_DELETE", "APP_UNINSTALL"]
        return 'Invalid event' unless (available_events.include? event_type)
        callback_url = URI.parse("#{self.protocol}://#{self.host}/rs/shops/#{self.name.to_s}/webhooks/#{webhook_id}").to_s
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
