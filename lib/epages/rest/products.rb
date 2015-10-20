require 'epages/rest/utils'
require 'epages/rest/products'

module Epages
  module REST
    # implements the calls in https://developer.epages.com/apps/api-reference/resource-product.html
    module Products
      include REST::Utils

      # implements the call https://developer.epages.com/apps/api-reference/get-shops-shopid-products.html
      def products(options = {})
        perform_get_with_key_and_objects('/products', options, :items, Epages::Product)
      end

      # implements the call https://developer.epages.com/apps/api-reference/get-shops-shopid-products-productid.html
      def product(object, options = {})
        id = object_id(object)
        perform_get_with_object("/products/#{id}", options, Epages::Product)
      end
    end
  end
end
