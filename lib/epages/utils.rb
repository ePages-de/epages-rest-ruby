require 'active_support/inflector'
require 'date'
require 'uri'
require 'json'

module Epages
  module Utils
  module_function

    # creates a instance variable (underscore) from the [data]
    # if [klass] is passed, creates a object of [klass] initialized with data
    #
    # @param name [Symbol] [String]
    # @param data [Hash]
    # @param klass [Class]
    def parse_attribute_as(name, data, klass = NilClass)
      return if data.nil?
      value =
        case klass.name
        when 'NilClass' then data
        when 'DateTime' then klass.parse(data)
        else klass.new(data)
        end
      instance_variable_set("@#{name.to_s.underscore}", value)
    end

    # creates a instance variable (underscore). This variable contains an array of <klass> or empty array
    #
    # @param name [Symbol] [String]
    # @param data [Hash]
    # @param klass [Class]
    def parse_attribute_as_array_of(name, data, klass)
      value = data.class != Array || data.empty? ? [] : data.collect { |i| klass.new(i) }
      instance_variable_set("@#{name.to_s.underscore}", value)
    end

    # creates instance variables from the data
    # if klass is passed, create a object initializing with data
    #
    # @param data [Hash]
    # @param klass [Class]
    def parse_attributes(data, klass = nil)
      data.keys.each do |key|
        next if data[key.to_sym].nil?
        value = klass.nil? ? data[key.to_sym] : klass.new(data[key.to_sym])
        instance_variable_set("@#{key.to_s.underscore}", value)
      end
    end

    # return the hash with the keys converted to lower camelcase
    #
    # @param hash [Hash]
    def camelize_keys(hash)
      return unless hash.is_a?(Hash)
      other = {}
      hash.keys.each do |k|
        key = k.to_s.camelize(:lower).to_sym
        other[key] = hash[k]
      end
      other
    end

    # return the hash with the keys converted to underscore
    #
    # @param hash [Hash]
    def underscorize_keys(hash)
      return unless hash.is_a?(Hash)
      hash.keys.each do |k|
        key = k.to_s.underscore.to_sym
        hash[key] = hash[k]
        hash.delete(k) if key != k
      end
      hash
    end

    # returns a shop. If [shop] is not a Epages::REST::Shop create one calling the [shop] method shop_mame
    def build_shop_from(shop)
      return shop if shop.is_a? Epages::REST::Shop
      Epages::REST::Shop.new(shop.host, shop.shop_name)
    end

    # returns the object replacing all the keys as symbols
    #
    # @param object [Hash], [Array]
    def symbolize_keys!(object)
      if object.is_a?(Array)
        object.each_with_index { |val, index| object[index] = symbolize_keys!(val) }
      elsif object.is_a?(Hash)
        object.keys.each { |key| object[key.to_sym] = symbolize_keys!(object.delete(key)) }
      end
      object
    end

    # returns the json body for the patch calls
    #
    # @param options [Hash]
    def options_to_patch_request(options)
      json = []
      Array[options.delete(:remove)].flatten.compact.each { |i| json << {'op' => 'remove', 'path' => "/#{camelize_words(i)}"} }
      options.each { |k, v| json << {'op' => 'add', 'path' => "/#{camelize_words(k)}", 'value' => v} }
      json.collect { |i| Hash[i.each_pair.to_a] }
    end

    # returns the json body for the patch calls
    #
    # @param options [Hash]
    def options_to_multipart_request(options)
      file = options[:file]
      @request_method = :post
      {image: HTTP::FormData::File.new(file, filename: File.basename(file), mime_type: mime_type(File.basename(file)))}
    end

    # return the string passed as a parameter with all the words camelized
    #
    # @param string [Strimg], [Symbol]
    def camelize_words(string)
      string.to_s.gsub(/(\w+)/) { |s| s.camelize(:lower) }
    end

    # return a string that acts as a query parameters (for POST calls)
    #
    # @param options [Hash]
    def to_query_options(options)
      return '' if !options.is_a?(Hash) || options.empty?
      "?#{options.map{ |k,v| "#{k}=#{v}" }.join('&')}"
    end
  end
end
