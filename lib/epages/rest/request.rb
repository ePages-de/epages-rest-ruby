require 'http'
require 'epages/utils'

module Epages
  module REST
    class Request
      include Epages::Utils

      attr_accessor :shop, :uri, :path, :request_method, :options, :headers

      def initialize(object, request_method, path, options = {})
        @shop = build_shop_from(object)
        @uri = URI.parse("#{@shop.protocol}://#{@shop.host}/rs/shops/#{@shop.name.to_s + path}")
        @path = uri.path
        set_request_options(request_method, options)
      end

      def set_request_options(method, options)
        @request_method = method
        @is_a_new_webhook = new_webhook?(path)
        @status_webhook = edit_webhook?(path)
        @headers = request_headers
        @options = format_options(options)
      end

      def auth_token
        "Bearer #{@shop.token}"
      end

      # @return [Array, Hash]
      def perform
        response = HTTP.headers(accept: @headers['Accept'],
                                authorization: @headers['Authorization'],
                                content_type: @headers['Content-Type'],
                                user_agent: @headers['User-Agent']).public_send(@request_method, @uri.to_s, options_passed_by => @options)
        fail_or_return_response_body(response)
      end

      def request_headers
        headers = {}
        headers['Content-Type']  = content_type_options unless @request_method == :multipart_post
        headers['Accept']        = '*/*'
        headers['Authorization'] = auth_token if @shop.token?
        headers['User-Agent'] = 'ruby gem'
        headers
      end

      def options_passed_by
        return :body if @is_a_new_webhook
        return :form if @status_webhook
        return :form if (@request_method == :post && @options.key?(:image))
        case @request_method
        when :get   then :params
        when :patch then :body
        else :json
        end
      end

      def content_type_options
        return 'application/x-www-form-urlencoded' if @status_webhook
        @request_method == :patch ? 'application/json-patch+json' : 'application/json'
      end

      def format_options(options)
        # return options if @status_webhook
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

      def new_webhook?(path)
        (path.to_s == "/webhooks") && (@request_method == :post)
      end

      def edit_webhook?(path)
        (path.to_s.include? "/webhooks/") && (@request_method == :post)
      end
    end
  end
end
