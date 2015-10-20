require 'epages/utils'

module Epages
  class Link
    include Epages::Utils

    attr_accessor :rel, :href

    def initialize(data)
      parse_attributes(data)
    end
  end
end
