require 'epages/utils'
require 'epages/error'
require 'epages/image'
require 'epages/link'
require 'epages/price_info'

module Epages
  class Product
    include Epages::Utils

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

    def relative_links
      @links.collect(&:rel)
    end

    def relative_link(title)
      relative_links.include? title
    end
  end
end
