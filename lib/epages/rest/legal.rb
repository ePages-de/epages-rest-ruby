require 'epages/rest/utils'

module Epages
  module REST
    # implements the calls in https://developer.epages.com/apps/api-reference/resource-legal.html
    module Legal
      # implements the call https://developer.epages.com/apps/api-reference/get-shops-shopid-legal.html
      def legal(options = {})
        response = perform_get_request('/legal', options)
        parse_legal_info(response)
      end

      # implements the call https://developer.epages.com/apps/api-reference/get-shops-shopid-legal-contact-information.html
      def contact_info(options = {})
        perform_get_with_object('/legal/contact-information', options, Epages::Legal)
      end

      # implements the call https://developer.epages.com/apps/api-reference/put-shops-shopid-legal-contact-information.html
      def update_contact_info(options)
        perform_put_with_object('/legal/contact-information', options, Epages::Legal)
      end

      # implements the call https://developer.epages.com/apps/api-reference/get-shops-shopid-legal-privacy-policy.html
      def privacy_policy(options = {})
        perform_get_with_object('/legal/privacy-policy', options, Epages::Legal)
      end

      # implements the call https://developer.epages.com/apps/api-reference/put-shops-shopid-legal-privacy-policy.html
      def update_privacy_policy(options)
        perform_put_with_object('/legal/privacy-policy', options, Epages::Legal)
      end

      # implements the call https://developer.epages.com/apps/api-reference/get-shops-shopid-legal-terms-and-conditions.html
      def terms_and_conditions(options = {})
        perform_get_with_object('/legal/terms-and-conditions', options, Epages::Legal)
      end

      # implements the call https://developer.epages.com/apps/api-reference/put-shops-shopid-legal-terms-and-conditions.html
      def update_terms_and_conditions(options)
        perform_put_with_object('/legal/terms-and-conditions', options, Epages::Legal)
      end

      # implements the call https://developer.epages.com/apps/api-reference/get-shops-shopid-legal-rights-of-withdrawal.html
      def rights_of_withdrawal(options = {})
        perform_get_with_object('/legal/rights-of-withdrawal', options, Epages::Legal)
      end

      # implements the call https://developer.epages.com/apps/api-reference/put-shops-shopid-legal-rights-of-withdrawal.html
      def update_rights_of_withdrawal(options)
        perform_put_with_object('/legal/rights-of-withdrawal', options, Epages::Legal)
      end

      # implements the call https://developer.epages.com/apps/api-reference/get-shops-shopid-legal-shipping-information.html
      def shipping_info(options = {})
        perform_get_with_object('/legal/shipping-information', options, Epages::Legal)
      end

      # implements the call https://developer.epages.com/apps/api-reference/put-shops-shopid-legal-shipping-information.html
      def update_shipping_info(options)
        perform_put_with_object('/legal/shipping-information', options, Epages::Legal)
      end
    end
  end
end
