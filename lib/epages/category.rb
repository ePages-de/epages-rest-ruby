require 'epages/utils'
require 'epages/error'

module Epages
  class Category
    include Epages::Utils

    KEYS = %w(category_id name page_title description special_offer images parent sub_categories sf_url links).collect(&:to_sym).freeze

    attr_reader *KEYS

    def initialize(data)
      @images = data.delete(:images).collect { |i| Epages::Image.new(i) } if data[:images]
      @links = data.delete(:links).collect { |i| Epages::Link.new(i) } if data[:links]
      @sub_categories = data.delete(:subCategories).collect { |i| Epages::Link.new(i) } if data[:subCategories]
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
