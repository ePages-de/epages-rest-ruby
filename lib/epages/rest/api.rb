# require 'epages/rest/carts'
require 'epages/rest/categories'
require 'epages/rest/legal'
require 'epages/rest/shipping_methods'
require 'epages/rest/products'

module Epages
  module REST
    module API
      # include REST::Carts
      include REST::Categories
      include REST::Legal
      include REST::ShippingMethods
      include REST::Products
    end
  end
end
