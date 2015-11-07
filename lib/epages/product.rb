require 'epages/utils'
require 'epages/error'
require 'epages/image'
require 'epages/link'
require 'epages/price_info'
require 'epages/rest/products'

module Epages
  class Product
    include Epages::Utils
    include Epages::REST::Products

    KEYS = %w(product_id name short_description description images price_info for_sale special_offer delivery_weight
              shipping_methods_restricted_to availability_text availability energy_labels_string energy_label_source_file
              product_data_sheet sf_url product_number manufacturer upc ean links).collect(&:to_sym).freeze

    attr_reader *KEYS

    def initialize(data)
      parse_attribute_as_array_of(:images, data.delete(:images), Epages::Image)
      parse_attribute_as_array_of(:links, data.delete(:links), Epages::Link)
      parse_attribute_as(:priceInfo, data.delete(:priceInfo), Epages::PriceInfo)
      parse_attributes(data)
    end

    # compare the product with another product. 2 products are considered equals if both has
    # the same id, the same name and the same product_number
    def ==(other)
      return false unless other.is_a? Epages::Product
      product_id == other.product_id && name == other.name && product_number == other.product_number
    end

    # returns the name of the shop that belongs the product
    def shop_name
      sf_url[%r{epages\/(\w+)}, 1]
    end

    # returns the list of links
    def links_title
      links.collect(&:rel)
    end

    # returns true if [name] is included in the list of links
    def link?(name)
      links_title.include? name
    end

    # returns the list of slides of the product
    def slideshow
      product_slideshow(self) if link?('slideshow')
    end

    # returns the list of variations of the product
    def variations
      product_variations(self) if link?('variations')
    end

    # returns the list of custom_attributes of the product
    def custom_attributes
      product_custom_attributes(self) if link?('custom-attributes')
    end

    # returns the categories of the product
    def categories
      product_categories(self) if link?('categories')
    end

    # returns the lowest price of all the variations of the product
    def lowest_price
      product_lowest_price(self) if link?('lowest-price')
    end

    # returns the stock level of the product
    def stock_level
      product_stock_level(self)[:stocklevel]
    end

    # modify the current stock level in [units]
    #
    # @param units [Fixnum]. Number of units to change. Can be negative
    # @param shop [Epages::Shop]. The shop that contains the authorization to do the call
    def change_stock_level_in(units, shop)
      shop.change_product_stock_level(self, units)[:stocklevel]
    end

    # return a hash with productId and quantity. This format is used for the line_items of Cart
    def to_line_item(quantity = 1)
      {productId: product_id, quantity: quantity}
    end
  end
end
