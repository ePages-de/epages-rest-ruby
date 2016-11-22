require 'epages/rest/carts'
require 'epages/rest/categories'
require 'epages/rest/customers'
require 'epages/rest/legal'
require 'epages/rest/miscellaneous'
require 'epages/rest/newsletters'
require 'epages/rest/orders'
require 'epages/rest/products'
require 'epages/rest/sales'
require 'epages/rest/shipping_methods'
require 'epages/rest/tax_classes'

module Epages
  module REST
    module API
      include REST::Carts
      include REST::Categories
      include REST::Customers
      include REST::Legal
      include REST::Miscellaneous
      include REST::Newsletters
      include REST::Orders
      include REST::Products
      include REST::Sales
      include REST::ShippingMethods
      include REST::TaxClasses
    end
  end
end
