require 'epages/rest/utils'
require 'epages/rest/products'

module Epages
  module REST
    # implements the calls in https://developer.epages.com/apps/api-reference/resource-product.html
    module Products
      include REST::Utils

      def products(options = {})
        perform_get_with_key_and_objects('/products', options, :items, Epages::Product)
      end
    end
  end
end
