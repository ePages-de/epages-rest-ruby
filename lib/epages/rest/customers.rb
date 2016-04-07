require 'epages/rest/utils'

module Epages
  module REST
    # implements the calls in https://developer.epages.com/apps/api-reference/resource-customers.html
    module Customers
      include REST::Utils

      # call the API to creates a customer. If customer_number is not provided in the request, it will be generated automatically.
      # implements the call https://developer.epages.com/apps/api-reference/post-shops-shopid-customers.html
      #
      # @param options [Hash]
      def create_customer(options = {})
        perform_post_with_object('/customers', options, Epages::Customer)
      end

      # call the API and returns a specified customer
      # implements the call https://developer.epages.com/apps/api-reference/get-shops-shopid-customers-customerid.html
      #
      # @param customer [String], [Epages::Customer]
      def customer(customer)
        id = epages_id(customer)
        perform_get_with_object("/customers/#{id}", {}, Epages::Customer)
      end

      # call the API to update the information for a single customer
      # implements the call https://developer.epages.com/apps/api-reference/patch-shops-shopid-customers-customerid.html
      #
      # @param customer [String], [Epages::Product]
      # @param options [Hash]
      def update_customer(customer, options = {})
        id = epages_id(customer)
        perform_patch_with_object("/customers/#{id}", options, Epages::Customer)
      end
    end
  end
end
