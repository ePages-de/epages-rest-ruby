require 'epages/utils'
require 'epages/rest/utils'

module Epages
  module REST
    # implements the calls in https://developer.epages.com/apps/api-reference/resource-carts.html
    module Carts
      include REST::Utils

      # implements the call https://developer.epages.com/apps/api-reference/post-shops-shopid-carts.html
      def create_cart(data = {})
        default = {currency: 'EUR', taxType: 'GROSS', locale: 'en_GB', lineItems: []}
        perform_post_with_object('/carts', default.merge(camelize_keys(data)), Epages::Cart)
      end

      # implements the call https://developer.epages.com/apps/api-reference/get-shops-shopid-carts-cartid.html
      def cart(cart)
        id = epages_id(cart)
        perform_get_with_object("/carts/#{id}", {}, Epages::Cart)
      end

      # implements the call https://developer.epages.com/apps/api-reference/post-shops-shopid-carts-cartid-line-items.html
      def cart_line_item(cart, product, quantity = 1)
        id = epages_id(cart)
        lineitem = product.is_a?(Epages::Product) ? product.to_line_item(quantity) : product
        perform_post_with_object("/carts/#{id}/line-items", lineitem, Epages::Cart)
      end
      alias_method :add_product_to_cart, :cart_line_item

      # implements the call https://developer.epages.com/apps/api-reference/put-shops-shopid-carts-cartid-line-items-lineitemid.html
      def update_cart_line_item(cart, lineitem, options)
        id = epages_id(cart)
        lineitem = lineitem.line_item_id if lineitem.is_a?(Epages::ProductLineItem)
        perform_put_with_object("/carts/#{id}/line-items/#{lineitem}", options, Epages::Cart)
      end

      # implements the call https://developer.epages.com/apps/api-reference/delete-shops-shopid-carts-cartid-line-items-lineitemid.html
      def delete_cart_line_item(cart, lineitem)
        id = epages_id(cart)
        lineitem = lineitem.line_item_id if lineitem.is_a?(Epages::ProductLineItem)
        perform_delete_with_object("/carts/#{id}/line-items/#{lineitem}", {}, Epages::Cart)
      end

      # implements the call https://developer.epages.com/apps/api-reference/put-shops-shopid-carts-cartid-billing-address.html
      def update_cart_billing_address(cart, address)
        id = epages_id(cart)
        address = address.to_json if address.is_a?(Epages::Address)
        perform_put_with_object("/carts/#{id}/billing-address", address, Epages::Cart)
      end

      # implements the call https://developer.epages.com/apps/api-reference/delete-shops-shopid-carts-cartid-billing-address.html
      def delete_billing_address(cart)
        id = epages_id(cart)
        perform_delete_with_object("/carts/#{id}/billing-address", {}, Epages::Cart)
      end

      # implements the call https://developer.epages.com/apps/api-reference/put-shops-shopid-carts-cartid-shipping-address.html
      def update_cart_shipping_address(cart, address)
        id = epages_id(cart)
        address = address.to_json if address.is_a?(Epages::Address)
        perform_put_with_object("/carts/#{id}/shipping-address", address, Epages::Cart)
      end

      # implements the call https://developer.epages.com/apps/api-reference/delete-shops-shopid-carts-cartid-shipping-address.html
      def delete_shipping_address(cart)
        id = epages_id(cart)
        perform_delete_with_object("/carts/#{id}/shipping-address", {}, Epages::Cart)
      end
    end
  end
end
