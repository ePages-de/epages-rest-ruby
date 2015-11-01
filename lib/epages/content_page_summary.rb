require 'epages/utils'

module Epages
  class ContentPageSummary
    include Epages::Utils

    attr_accessor :name

    def initialize(data)
      @name = data[:name]
    end
  end
end
