require 'epages/utils'

module Epages
  class ImageSize
    include Epages::Utils

    attr_accessor :images

    def initialize(data)
      parse_attribute_as_array_of(:images, data[:sizes], Epages::Image)
    end

    # return a sorted array with the name of all available sizes
    def sizes
      images.collect(&:classifier).sort
    end

    # return the link of image with the indicated size
    #
    # @param size [String]. The name of the image classifier
    def size_link(size)
      images.find { |i| i.classifier == size }.url
    end
  end
end
