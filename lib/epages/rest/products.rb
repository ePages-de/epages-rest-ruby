require 'epages/rest/utils'

module Epages
  module REST
    # implements the calls in https://developer.epages.com/apps/api-reference/resource-product.html
    module Products
      include REST::Utils

      # call the API and return an array of Epages::Product
      # implements the call https://developer.epages.com/apps/api-reference/get-shops-shopid-products.html
      #
      # @param options [Hash]
      def products(options = {})
        perform_get_with_key_and_objects('/products', options, :items, Epages::Product)
      end

      # call the API and return a Epages::Product
      # implements the call https://developer.epages.com/apps/api-reference/get-shops-shopid-products-productid.html
      #
      # @param product [String], [Epages::Product]
      # @param options [Hash]
      def product(product, options = {})
        id = epages_id(product)
        perform_get_with_object("/products/#{id}", options, Epages::Product)
      end

      # call the API and return a Hash with the respective variation_attributes and the variation products
      # implements the call https://developer.epages.com/apps/api-reference/get-shops-shopid-products-productid-variations.html
      #
      # @param product [String], [Epages::Product]
      # @param options [Hash]
      def product_variations(product, options = {})
        id = epages_id(product)
        response = perform_get_request("/products/#{id}/variations", options)
        parse_product_variations(response)
      end

      # call the API and return an array of Epages::ImageSize (slides) of the product
      # implements the call https://developer.epages.com/apps/api-reference/get-shops-shopid-products-productid-slideshow.html
      #
      # @param product [String], [Epages::Product]
      def product_slideshow(product)
        id = epages_id(product)
        perform_get_with_key_and_objects("/products/#{id}/slideshow", {}, :items, Epages::ImageSize)
      end

      # call the API and return an array of Epages::CustomAttribute of the product
      # implements the call https://developer.epages.com/apps/api-reference/get-shops-shopid-products-productid-custom-attributes.html
      #
      # @param product [String], [Epages::Product]
      # @param options [Hash]
      def product_custom_attributes(product, options = {})
        id = epages_id(product)
        perform_get_with_key_and_objects("/products/#{id}/custom-attributes", options, :items, Epages::CustomAttribute)
      end

      # call the API and return a hash with the lowest price of the product and the respective link
      # implements the call https://developer.epages.com/apps/api-reference/get-shops-shopid-products-productid-lowest-price.html
      #
      # @param product [String], [Epages::Product]
      # @param options [Hash]
      def product_lowest_price(product, options = {})
        id = epages_id(product)
        response = perform_get_request("/products/#{id}/lowest-price", options)
        parse_product_lowest_price(response)
      end

      # call the API and return an array of Epages::Link pointing to the categories of the product
      # implements the call https://developer.epages.com/apps/api-reference/get-shops-shopid-products-productid-categories.html
      #
      # @param product [String], [Epages::Product]
      # @param options [Hash]
      def product_categories(product, options = {})
        id = epages_id(product)
        perform_get_with_key_and_objects("/products/#{id}/categories", options, :links, Epages::Link)
      end

      # call the API and return a hash that contains the stock-level
      # implements the call https://developer.epages.com/apps/api-reference/get-shops-shopid-products-productid-stock-level.html
      #
      # @param product [String], [Epages::Product]
      def product_stock_level(product)
        id = epages_id(product)
        perform_get_request("/products/#{id}/stock-level", {})
      end

      # call the API to modify the current stock level of the product
      # implements the call https://developer.epages.com/apps/api-reference/get-shops-shopid-products-productid-stock-level.html
      #
      # @param product [String], [Epages::Product]
      # @param units [Fixnum]
      def change_product_stock_level(product, units)
        id = epages_id(product)
        perform_put_request("/products/#{id}/stock-level", changeStocklevel: units)
      end

      # call the API and return a CSV with the proper data of the products
      # implements the call https://developer.epages.com/apps/api-reference/get-shops-shopid-products-export.html
      #
      # @param options [Hash]
      def export_products(options = {})
        perform_get_request('/products/export', options)
      end
    end
  end
end
