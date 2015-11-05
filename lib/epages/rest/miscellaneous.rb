require 'epages/utils'
require 'epages/rest/utils'

module Epages
  module REST
    # implement the calls in https://developer.epages.com/apps/api-reference/resource-miscellaneous.html
    module Miscellaneous
      include Epages::Utils

      # implements the call https://developer.epages.com/apps/api-reference/get-shops-shopid-locales.html
      def locales
        perform_get_request('/locales', {})
      end

      # implements the call https://developer.epages.com/apps/api-reference/get-shops-shopid-currencies.html
      def currencies
        perform_get_request('/currencies', {})
      end

      # implements the call https://developer.epages.com/apps/api-reference/get-shops-shopid-search-product-suggest.html
      def product_suggestions_for(query, options = {})
        response = perform_get_request('/search/product-suggest', options.merge(query: query))
        parse_suggestions_to_products(response)
      end
    end
  end
end
