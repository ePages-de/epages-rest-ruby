require 'active_support/inflector'
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
  end
end
