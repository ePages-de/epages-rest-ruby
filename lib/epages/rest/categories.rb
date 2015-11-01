require 'epages/rest/utils'
require 'epages/category'

module Epages
  module REST
    module Categories
      # implements the calls in https://developer.epages.com/apps/api-reference/resource-category.html
      include REST::Utils

      # implements the calls in https://developer.epages.com/apps/api-reference/get-shops-shopid-categories.html
      def categories(options = {})
        perform_get_with_objects('/categories', options, Epages::Category)
      end

      # implements the calls in https://developer.epages.com/apps/api-reference/get-shops-shopid-categories-categoryid.html
      def category(object, options = {})
        id = object_id(object)
        perform_get_with_object("/categories/#{id}", options, Epages::Category)
      end

      # implements the calls in https://developer.epages.com/apps/api-reference/put-shops-shopid-categories-categoryid.html
      def update_category(object, options)
        id = object_id(object)
        options[:categoryId] = id
        perform_put_with_object("/categories/#{id}", options, Epages::Category)
      end
    end
  end
end
