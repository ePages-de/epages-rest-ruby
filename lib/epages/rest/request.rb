require 'http'
require 'epages/utils'

module Epages
  module REST
    class Request
      include Epages::Utils

      BASE_URL = 'https://pm.epages.com/rs/shops/'
      attr_accessor :shop, :uri, :path, :request_method, :options, :headers

      def initialize(object, request_method, path, options = {})
        @shop = build_shop_from(object)
        @uri = URI.parse(BASE_URL + @shop.name.to_s + path)
        @path = uri.path
        set_options(request_method, options)
      end

      def set_options(method, options)
        @options = camelize_keys(options)
        @request_method = method
        @headers = request_headers
      end

      def auth_token
        "Bearer #{@shop.token}"
      end

      # @return [Array, Hash]
      def perform
        options_key = @request_method == :get ? :params : :json
        response = HTTP.with(@headers).public_send(@request_method, @uri.to_s, options_key => @options)
        fail_or_return_response_body(response)
      end

      def request_headers
        headers = {}
        headers['Content-Type']  = 'application/json'
        headers['Accept']        = '*/*'
        headers['Authorization'] = auth_token if @shop.token?
        headers
      end

      def fail_or_return_response_body(response)
        if response.code.between?(200, 206)
          symbolize_keys!(response.parse)
        else
          fail Epages::Error::ERRORS[response.code], JSON.parse(response.body.to_s)['message']
        end
      end
    end
  end
end
