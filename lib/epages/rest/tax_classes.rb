require 'epages/rest/utils'

module Epages
  module REST
    # implements the calls in https://developer.epages.com/apps/api-reference/resource-tax-classes
    module TaxClasses
      include REST::Utils

      # implements the call https://developer.epages.com/apps/api-reference/get-shops-shopid-tax-classes-taxclassid.html
      def tax_class(tax, options = {})
        id = epages_id(tax)
        perform_get_with_object("/tax-classes/#{id}", options, Epages::TaxClass)
      end

      # implements the call https://developer.epages.com/apps/api-reference/get-shops-shopid-tax-classes.html
      def tax_classes(newsletter, options = {})
        id = epages_id(newsletter)
        perform_get_with_objects("/tax-classes/", options, :items, Epages::TaxClass)
      end
    end
  end
end