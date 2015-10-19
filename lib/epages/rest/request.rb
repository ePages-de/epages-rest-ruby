require 'uri'
require 'http'
require 'json'

module Epages
  module REST
    class Request
      BASE_URL = 'https://pm.epages.com/rs/shops/'
      attr_accessor :shop, :uri, :path, :request_method, :options, :headers

      def initialize(shop, request_method, path, options = {})
        @shop = shop
        @uri = URI.parse(path.start_with?('http') ? path : BASE_URL + path)
        @path = uri.path
        set_options(request_method, options)
      end

      def set_options(method, options)
        @options = options
        @request_method = request_method
        @headers = request_headers
      end

      def auth_token
        "Token #{@shop.token}"
      end

      # @return [Array, Hash]
      def perform
        options_key = @request_method == :get ? :params : :form
        response = HTTP.with(@headers).public_send(@request_method, @uri.to_s, options_key => @options)
        response_body = symbolize_keys!(response.parse)
        response_headers = response.headers
        fail_or_return_response_body(response.code, response_body, response_headers)
      end

      def request_headers
        headers = {}
        headers['Content-Type']  = 'application/json'
        headers['Accept']        = 'application/vnd.epages.mate.v1+json'
        headers['Authorization'] = auth_token if @shop.token_request?
        headers
      end

      def symbolize_keys!(object)
        if object.is_a?(Array)
          object.each_with_index do |val, index|
            object[index] = symbolize_keys!(val)
          end
        elsif object.is_a?(Hash)
          object.keys.each do |key|
            object[key.to_sym] = symbolize_keys!(object.delete(key))
          end
        end
        object
      end

      def fail_or_return_response_body(code, body, headers)
        error = error(code, body, headers)
        fail(error) if error
        body
      end
    end
  end
end