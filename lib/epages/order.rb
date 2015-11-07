require 'epages/utils'
require 'epages/error'

module Epages
  class Order
    include Epages::Utils

    KEYS =  %w(category_id name page_title description special_offer images parent sub_categories sf_url links).collect(&:to_sym).freeze

    attr_reader *KEYS

    def initialize(data)
      @images = data.delete(:images).collect { |i| Epages::Image.new(i) }
      @links = data.delete(:links).collect { |i| Epages::Link.new(i) }
      @sub_categories = data.delete(:subCategories).collect { |i| Epages::Link.new(i) }
      @parent = Epages::Link.new(data.delete(:parent)) if data[:parent]
      parse_attributes(data)
    end
  end
end
