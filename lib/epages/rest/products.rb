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

      # implements the call https://developer.epages.com/apps/api-reference/get-shops-shopid-products-productid-variations.html
      def product_variations(object, options = {})
        id = object_id(object)
        response = perform_get_request("/products/#{id}/variations", options)
        parse_product_variations(response)
      end

      # implements the call https://developer.epages.com/apps/api-reference/get-shops-shopid-products-productid-slideshow.html
      def product_slideshow(object)
        id = object_id(object)
        response = perform_get_request("/products/#{id}/slideshow", {})
        # TODO: pending to get the standard data-types
      end

      # implements the call https://developer.epages.com/apps/api-reference/get-shops-shopid-products-productid-custom-attributes.html
      def product_custom_attributes(object, options = {})
        id = object_id(object)
        perform_get_with_key_and_objects("/products/#{id}/custom-attributes", options, :items, Epages::CustomAttribute)
      end

      # implements the call https://developer.epages.com/apps/api-reference/get-shops-shopid-products-productid-lowest-price.html
      def product_lowest_price(object, options = {})
        id = object_id(object)
        response = perform_get_request("/products/#{id}/lowest-price", options)
        parse_product_lowest_price(response)
      end

      # implements the call https://developer.epages.com/apps/api-reference/get-shops-shopid-products-productid-categories.html
      def product_categories(object, options = {})
        id = object_id(object)
        perform_get_with_key_and_objects("/products/#{id}/categories", options, :links, Epages::Link)
      end

      # implements the call https://developer.epages.com/apps/api-reference/get-shops-shopid-products-productid-stock-level.html
      def product_stock_level(object)
        id = object_id(object)
        perform_get_request("/products/#{id}/stock-level", {})
      end

      # implements the call https://developer.epages.com/apps/api-reference/get-shops-shopid-products-productid-stock-level.html
      def change_product_stock_level(object, options)
        id = object_id(object)
        perform_put_request("/products/#{id}/stock-level", options)
      end

      # implements the call https://developer.epages.com/apps/api-reference/get-shops-shopid-products-export.html
      def export_products(options = {})
        perform_get_request('/products/export', options)
      end
    end
  end
end
