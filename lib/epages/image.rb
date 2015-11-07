require 'epages/utils'

module Epages
  class Image
    include Epages::Utils

    attr_reader :url, :classifier

    def initialize(data)
      parse_attributes(data)
    end
  end
end
