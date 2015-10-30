require 'epages/error'

module Epages
  class Shop
    attr_accessor :name, :token

    def initialize(name, token = nil)
      @name = name
      @token = token
    end

    def token?
      !!token
    end
  end
end
