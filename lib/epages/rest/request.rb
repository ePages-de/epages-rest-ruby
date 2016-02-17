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
        @headers = request_headers
        @options = format_options(options)
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
        headers['Content-Type']  = content_type_options unless @request_method == :multipart_post
        headers['Accept']        = '*/*'
        headers['Authorization'] = auth_token if @shop.token?
        headers
      end

      def options_passed_by
        return :form if @request_method == :post && @options.key?(:image)
        case @request_method
        when :get   then :params
        when :patch then :body
        else :json
        end
      end

      def content_type_options
        @request_method == :patch ? 'application/json-patch+json' : 'application/json'
      end

      def format_options(options)
        case @request_method
        when :multipart_post then options_to_multipart_request(options)
        when :patch then options_to_patch_request(options).to_json
        else options.is_a?(Hash) ? camelize_keys(options) : options
        end
      end

      def mime_type(basename)
        case basename
        when /.gif/   then 'image/gif'
        when /.jpe?g/ then 'image/jpeg'
        when /.png/   then 'image/png'
        else 'application/octet-stream'
        end
      end

      def fail_or_return_response_body(response)
        return if response.code == 204
        if response.code.between?(200, 206)
          symbolize_keys!(response.parse)
        else
          fail Epages::Error::ERRORS[response.code], response.body.to_s
        end
      end
    end
  end
end
