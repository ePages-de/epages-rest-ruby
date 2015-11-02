require 'epages/utils'
require 'epages/rest/utils'
require 'pry'

module Epages
  module REST
    # implements the calls in https://developer.epages.com/apps/api-reference/resource-legal.html
    module Legal
      include Epages::Utils
      # implements the call https://developer.epages.com/apps/api-reference/get-shops-shopid-legal.html
      def legal(options = {})
        response = perform_get_request('/legal', options)
        parse_legal_info(response)
      end

      # implements the call https://developer.epages.com/apps/api-reference/get-shops-shopid-legal-contact-information.html
      def contact_info(options = {})
        response = perform_get_request('/legal/contact-information', options)
        underscorize_keys(response)
      end

      # implements the call https://developer.epages.com/apps/api-reference/put-shops-shopid-legal-contact-information.html
      def update_contact_info(options, locale = 'en_GB')
        old_data = self.contact_info(locale: locale)
        response = perform_put_request("/legal/contact-information?locale=#{locale}", old_data.merge(options))
        underscorize_keys(response)
      end

      # implements the call https://developer.epages.com/apps/api-reference/get-shops-shopid-legal-privacy-policy.html
      def privacy_policy(options = {})
        response = perform_get_request('/legal/privacy-policy', options)
        underscorize_keys(response)
      end

      # implements the call https://developer.epages.com/apps/api-reference/put-shops-shopid-legal-privacy-policy.html
      def update_privacy_policy(options, locale = 'en_GB')
        old_data = self.privacy_policy(locale: locale)
        response = perform_put_request("/legal/privacy-policy?locale=#{locale}", old_data.merge(options))
        underscorize_keys(response)
      end

      # implements the call https://developer.epages.com/apps/api-reference/get-shops-shopid-legal-terms-and-conditions.html
      def terms_and_conditions(options = {})
        response = perform_get_request('/legal/terms-and-conditions', options)
        underscorize_keys(response)
      end

      # implements the call https://developer.epages.com/apps/api-reference/put-shops-shopid-legal-terms-and-conditions.html
      def update_terms_and_conditions(options, locale = 'en_GB')
        old_data = self.terms_and_conditions(locale: locale)
        response = perform_put_request("/legal/terms-and-conditions?locale=#{locale}", old_data.merge(options))
        underscorize_keys(response)
      end

      # implements the call https://developer.epages.com/apps/api-reference/get-shops-shopid-legal-rights-of-withdrawal.html
      def rights_of_withdrawal(options = {})
        response = perform_get_request('/legal/rights-of-withdrawal', options)
        underscorize_keys(response)
      end

      # implements the call https://developer.epages.com/apps/api-reference/put-shops-shopid-legal-rights-of-withdrawal.html
      def update_rights_of_withdrawal(options, locale = 'en_GB')
        old_data = self.rights_of_withdrawal(locale: locale)
        response = perform_put_request("/legal/rights-of-withdrawal?locale=#{locale}", old_data.merge(options))
        underscorize_keys(response)
      end

      # implements the call https://developer.epages.com/apps/api-reference/get-shops-shopid-legal-shipping-information.html
      def shipping_info(options = {})
        response = perform_get_request('/legal/shipping-information', options)
        underscorize_keys(response)
      end

      # implements the call https://developer.epages.com/apps/api-reference/put-shops-shopid-legal-shipping-information.html
      def update_shipping_info(options, locale = 'en_GB')
        old_data = self.shipping_info(locale: locale)
        response = perform_put_request("/legal/shipping-information?locale=#{locale}", old_data.merge(options))
        underscorize_keys(response)
      end
    end
  end
end
