require 'http'
require 'epages/utils'

module Epages
  module REST
    class Request
      include Epages::Utils

      attr_accessor :shop, :uri, :path, :request_method, :options, :headers

      def initialize(object, request_method, path, options = {})
        @shop = build_shop_from(object)
        @uri = URI.parse("https://#{@shop.host}/rs/shops/#{@shop.name.to_s + path}")
        @path = uri.path
        set_options(request_method, options)
      end

      def set_options(method, options)
        @options = method == :patch ? options_to_patch_request(options).to_json : camelize_keys(options)
        @request_method = method
        @headers = request_headers(method)
      end

      def auth_token
        "Bearer #{@shop.token}"
      end

      # @return [Array, Hash]
      def perform
        options_key = case @request_method
                      when :get   then :params
                      when :patch then :body
                      else :json
                      end
        response = HTTP.with(@headers).public_send(@request_method, @uri.to_s, options_key => @options)
        fail_or_return_response_body(response)
      end

      def request_headers(method)
        headers = {}
        headers['Content-Type']  = method == :patch ? 'application/json-patch+json' : 'application/json'
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
