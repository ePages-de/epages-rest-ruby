require 'epages/error'

module Epages
  class Shop
    attr_accessor :name, :token

    def initialize(name, token = nil)
      @name = name
      @token = token
    end

    # return the shop name
    def shop_name
      name
    end

    # retuns a boolean indicating if the shop has a token set
    def token?
      !!token
    end
  end
end
