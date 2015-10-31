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

    attr_accessor :product_id, :name, :short_description, :description, :images, :price_info,
                  :for_sale, :special_offer, :delivery_weight, :shipping_methods_restricted_to,
                  :availability_text, :availability, :energy_labels_string, :energy_label_source_file,
                  :product_data_sheet, :sf_url, :product_number, :manufacturer, :upc, :ean, :links

    def initialize(data)
      @images = data.delete(:images).collect { |i| Epages::Image.new(i) }
      @links = data.delete(:links).collect { |i| Epages::Link.new(i) }
      parse_attribute_as(:priceInfo, data.delete(:priceInfo), Epages::PriceInfo)
      parse_attributes(data)
    end

    def ==(other)
      return false if other.class != Epages::Product
      product_id == other.product_id &&
        name == other.name &&
        product_number == other.product_number
    end

    def shop_name
      %r{ sf_url[/epages\/(\w+)/i, 1] }
    end

    def links_title
      @links.collect(&:rel)
    end

    def link?(name)
      links_title.include? name
    end

    def slideshow
      product_slideshow(self) if link?('slideshow')
    end

    def custom_attributes
      product_custom_attributes(self) if link?('custom-attributes')
    end

    def categories
      product_categories(self) if link?('categories')
    end

    def lowest_price
      product_lowest_price(self) if link?('lowest-price')
    end

    def stock_level?
      product_stock_level(self)[:stocklevel]
    end

    def change_stock_level_in(units, shop)
      shop.change_product_stock_level(self, units)[:stocklevel]
    end
  end
end
