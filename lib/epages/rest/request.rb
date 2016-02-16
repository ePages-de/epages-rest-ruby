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
        set_request_options(request_method, options)
      end

      def set_request_options(method, options)
        @request_method = method
        @options = set_options(options)
        @headers = request_headers
      end

      def auth_token
        "Bearer #{@shop.token}"
      end

      # @return [Array, Hash]
      def perform
        response = HTTP.with(@headers).public_send(@request_method, @uri.to_s, options_passed_by => @options)
        fail_or_return_response_body(response)
      end

      def request_headers
        headers = {}
        headers['Content-Type']  = content_type_options unless @options[:image].is_a?(HTTP::FormData::File)
        headers['Accept']        = '*/*'
        headers['Authorization'] = auth_token if @shop.token?
        headers
      end

      def options_passed_by
        return :form if @options[:image].is_a?(HTTP::FormData::File)
        case @request_method
        when :get   then :params
        when :patch then :body
        else :json
        end
      end

      def content_type_options
        @request_method == :patch ? 'application/json-patch+json' : 'application/json'
      end

      def set_options(options)
        case @request_method
        when :multipart_post then options_to_multipart_request(options)
        when :patch then options_to_patch_request(options).to_json
        else camelize_keys(options)
        end
        # @request_method = :post if @request_method == :multipart_post
      end

      def mime_type(basename)
        case basename
          when %r{.gif}   then 'image/gif'
          when %r{.jpe?g} then 'image/jpeg'
          when %r{.png}   then 'image/png'
          else 'application/octet-stream'
        end
      end

      def fail_or_return_response_body(response)
        return if response.code == 204
        if response.code.between?(200, 206)
          symbolize_keys!(response.parse)
        else
          fail Epages::Error::ERRORS[response.code], JSON.parse(response.body.to_s)['message']
        end
      end
    end
  end
end
