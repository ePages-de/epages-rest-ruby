require "epages/shop"
require "epages/rest/api"
require "epages/rest/request"
require "epages/rest/utils"

module Epages
  module REST
    class Shop < Epages::Shop
      include Epages::REST::API
    end
  end
end