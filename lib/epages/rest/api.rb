# require 'epages/rest/carts'
# require 'epages/rest/categories'
# require 'epages/rest/legal'
# require 'epages/rest/shipping_methods'
require 'epages/rest/products'

module Epages
  module REST
    module API
      # include EPages::REST::Carts
      # include EPages::REST::Categories
      # include EPages::REST::Legal
      # include EPages::REST::ShippingMethods
      include REST::Products
    end
  end
end