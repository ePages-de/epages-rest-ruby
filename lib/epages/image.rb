require 'epages/utils'

module Epages
  class Image
    include Epages::Utils

    attr_accessor :url, :classifier

    def initialize(data)
      parse_attributes(data)
    end
  end
end
