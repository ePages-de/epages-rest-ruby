require 'epages/utils'
require 'epages/error'
require 'epages/image'
require 'epages/link'
require 'epages/price_info'

module Epages
  class Product
  	include Epages::Utils

    attr_accessor :name, :short_description, :description, :images, :priceInfo,
                  :forSale, :specialOffer, :deliveryWeight, :shippingMethodsRestrictedTo,
                  :availabilityText, :availability, :energyLabelsString, :energyLabelSourceFile,
                  :productDataSheet, :sfUrl, :productNumber, :manufacturer, :upc, :ean, :links

    def initialize(data)
      @images = data.delete(:images).collect { |i| Epages::Image.new(i) }
      @links = data.delete(:links).collect { |i| Epages::Link.new(i) }
      parse_attribute_as(:priceInfo, data.delete(:priceInfo), Epages::PriceInfo)
      parse_attributes(data)
    end
  end
end
