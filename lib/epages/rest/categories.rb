require 'epages/rest/utils'

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
        id = epages_id(object)
        perform_get_with_object("/categories/#{id}", options, Epages::Category)
      end

      # implements the call https://developer.epages.com/apps/api-reference/post-shops-shopid-categories-categoryid.html
      # The id can be from the root category or to create a subcategory
      def create_category(object, options = {})
        id = epages_id(object)
        perform_post_with_object("/categories/#{id}", options, Epages::Category)
      end

      # implements the calls in https://developer.epages.com/apps/api-reference/put-shops-shopid-categories-categoryid.html
      def update_category(object, options)
        id = epages_id(object)
        options[:categoryId] = id
        perform_put_with_object("/categories/#{id}", options, Epages::Category)
      end

      # implements the call https://developer.epages.com/apps/api-reference/delete-shops-shopid-categories-categoryid.html
      def delete_category(category)
        id = epages_id(category)
        perform_delete_request("/categories/#{id}")
      end

      # implements the call https://developer.epages.com/apps/api-reference/get-shops-shopid-categories-categoryid-sequence.html
      def subcategories(object)
        id = epages_id(object)
        perform_get_request("/categories/#{id}/sequence")
      end

      # implements the call https://developer.epages.com/apps/api-reference/put-shops-shopid-categories-categoryid-sequence.html
      def reorder_subcategories(object, data)
        id = epages_id(object)
        perform_put_request("/categories/#{id}/sequence", data)
      end

      # implements the call https://developer.epages.com/apps/api-reference/post-shops-shopid-product-category-assignments.html
      # Same as Epages::REST::Products#`assign_categories`
      def assign_products(options = {})
        perform_post_request('/product-category-assignments', options)
      end

      # implements the call https://developer.epages.com/apps/api-reference/delete-shops-shopid-product-category-assignments.html
      # Same as Epages::REST::Products#`delete_from_categories`
      def delete_products(options = {})
        perform_delete_request('/product-category-assignments', options)
      end
    end
  end
end
