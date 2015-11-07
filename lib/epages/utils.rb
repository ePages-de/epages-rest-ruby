require 'active_support/inflector'
require 'uri'
require 'json'
require 'pry'

module Epages
  module Utils
  module_function

    # creates instance variable from the data
    # if klass is passed, create a object initializing with data
    #
    # @param name [Symbol] [String]
    # @param data [Hash]
    # @param klass [Class]
    def parse_attribute_as(name, data, klass = nil)
      return if data.nil?
      value = klass.nil? ? data : klass.new(data)
      instance_variable_set("@#{name.to_s.underscore}", value)
    end

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

    # in order to work with camelcase or underscore-case indistinctly
    # return the hash with the keys converted to lower camelcase (the API works with camelcase)
    #
    # @param data [Hash]
    def camelize_keys(hash)
      hash.keys.each do |k|
        key = k.to_s.camelize(:lower).to_sym
        hash[key] = hash[k]
        hash.delete(k) if key != k
      end
      hash
    end

    # in order to work with camelcase or underscore-case indistinctly
    # return the hash with the keys converted to underscore (ruby convention: use underscore variables)
    #
    # @param data [Hash]
    def underscorize_keys(hash)
      hash.keys.each do |k|
        key = k.to_s.underscore.to_sym
        hash[key] = hash[k]
        hash.delete(k) if key != k
      end
      hash
    end

    # returns a shop receiving as a parameter an object
    def build_shop_from(object)
      return object if object.class == Epages::REST::Shop
      Epages::REST::Shop.new(object.shop_name)
    end

    # returns the object replacing all the keys as symbols
    def symbolize_keys!(object)
      if object.is_a?(Array)
        object.each_with_index { |val, index| object[index] = symbolize_keys!(val) }
      elsif object.is_a?(Hash)
        object.keys.each { |key| object[key.to_sym] = symbolize_keys!(object.delete(key)) }
      end
      object
    end

    # set the attr_readers from each class
    def set_attr_readers
      (class << self; self; end).send(:attr_reader, *keys)
    end
  end
end
