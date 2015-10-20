module Epages
  module REST
    module Utils
      # @param request_method [Symbol]
      # @param path [String]
      # @param options [Hash]
      def perform_request(request_method, path, options = {})
        Epages::REST::Request.new(self, request_method, path, options).perform
      end

      # @param path [String]
      # @param options [Hash]
      # @param klass [Class]
      def perform_get_with_object(path, options, klass)
        perform_request_with_object(:get, path, options, klass)
      end

      # @param path [String]
      # @param options [Hash]
      # @param klass [Class]
      def perform_post_with_object(path, options, klass)
        perform_request_with_object(:post, path, options, klass)
      end

      # @param request_method [Symbol]
      # @param path [String]
      # @param options [Hash]
      # @param klass [Class]
      def perform_request_with_object(request_method, path, options, klass)
        response = perform_request(request_method, path, options)
        klass.new(response)
      end

      # @param path [String]
      # @param options [Hash]
      # @param klass [Class]
      def perform_get_with_objects(path, options, klass)
        perform_request_with_objects(:get, path, options, klass)
      end

      # @param path [String]
      # @param options [Hash]
      # @param klass [Class]
      def perform_post_with_objects(path, options, klass)
        perform_request_with_objects(:post, path, options, klass)
      end

      # @param request_method [Symbol]
      # @param path [String]
      # @param options [Hash]
      # @param klass [Class]
      def perform_request_with_objects(request_method, path, options, klass)
        perform_request(request_method, path, options).collect do |element|
          klass.new(element)
        end
      end

      # @param path [String]
      # @param options [Hash]
      # @param key [Symbol]
      # @param klass [Class]
      def perform_get_with_key_and_objects(path, options, key, klass)
        perform_request_with_key_and_objects(:get, path, options, key, klass)
      end

      # @param path [String]
      # @param options [Hash]
      # @param key [Symbol]
      # @param klass [Class]
      def perform_post_with_key_and_objects(path, options, key, klass)
        perform_request_with_key_and_objects(:post, path, options, key, klass)
      end

      # @param path [String]
      # @param options [Hash]
      # @param key [Symbol]
      # @param klass [Class]
      def perform_request_with_key_and_objects(request_method, path, options, key, klass)
        perform_request(request_method, path, options)[key].collect do |element|
          klass.new(element)
        end
      end

      def object_id(object)
        return object if object.class == String
        id = object.class.name.demodulize.downcase + '_id'
        object.send(id)
      end
    end
  end
end
