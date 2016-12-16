require 'epages/utils'
require 'epages/error'

module Epages
  class Category
    include Epages::Utils

    KEYS = %w(category_id name page_title description special_offer images parent sub_categories sf_url links visible).collect(&:to_sym).freeze

    attr_reader *KEYS

    def initialize(data)
      parse_attribute_as_array_of('images', data.delete(:images), Epages::Image)
      parse_attribute_as_array_of('links', data.delete(:links), Epages::Link)
      parse_attribute_as_array_of('sub_categories', data.delete(:subCategories), Epages::Link)
      @parent = Epages::Link.new(data.delete(:parent)) if data[:parent]
      parse_attributes(data)
    end

    def ==(other)
      return false if other.class != Epages::Category
      category_id == other.category_id && name == other.name
    end

    alias_method :id, :category_id
  end
end
