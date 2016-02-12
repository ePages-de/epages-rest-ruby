require 'epages/rest/utils'

module Epages
  module REST
    # implements the calls in https://developer.epages.com/apps/api-reference/resource-sales.html
    module Sales
      include REST::Utils

      # call the API and return an array of Epages::Sale
      # implements the call https://developer.epages.com/apps/api-reference/get-shops-shopid-sales.html
      #
      # @param options [Hash]
      def sales(options = {})
        options[:product_id] = epages_id(options[:product_id]) if options[:product_id]
        perform_get_with_key_and_objects('/sales', format_dates_options(options), :salesPerCurrency, Epages::Sale)
      end
    end
  end
end
