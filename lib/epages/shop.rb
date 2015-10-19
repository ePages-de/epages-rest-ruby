require "epages/error"

module Epages
  class Shop
    attr_accessor :api_url, :token

    def initialize(name, token = nil)
      @api_url = BASE_URI + name
      @token = token
    end

    def token_request?
      !!token
    end
  end
end