require 'epages/utils'
require 'epages/rest/utils'

module Epages
  module REST
  	# implement the calls in https://developer.epages.com/apps/api-reference/resource-shipping-method.html
    module ShippingMethods
    	include Epages::Utils

    	# implements the call https://developer.epages.com/apps/api-reference/get-shops-shopid-shipping-methods.html
      def shipping_methods(options = {})
        perform_get_with_objects('/shipping-methods', options, Epages::ShippingMethod)
      end

      # implements the call https://developer.epages.com/apps/api-reference/get-shops-shopid-shipping-methods-shippingmethodid.html
      def shipping_method(object, options = {})
        id = object_id(object)
        perform_get_with_object("/shipping-methods/#{id}", options, Epages::ShippingMethod)
      end
    end
  end
end
