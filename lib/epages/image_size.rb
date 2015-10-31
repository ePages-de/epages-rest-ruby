require 'epages/image'

module Epages
  class ImageSize
    attr_accessor :sizes

    def initialize(data)
      @sizes = data[:sizes].collect { |i| Epages::Image.new(i) }
    end
  end
end
