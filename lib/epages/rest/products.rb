require 'epages/rest/utils'
require 'epages/rest/products'

module Epages
  module REST
    # implements the calls in https://developer.epages.com/apps/api-reference/resource-product.html
    module Products
      include REST::Utils

      def products
        perform_get_with_object('products', options, Epages::Product)
      end
    end
  end
end