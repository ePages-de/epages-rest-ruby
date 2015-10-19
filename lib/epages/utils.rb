module Epages
	module Utils

		# creates instance variable from the data
		# if klass is passed, create a object initializing with data
		#
		# @param name [Symbol] [String]
		# @param data [Hash]
		# @param klass [Class]
		def parse_attribute_as(name, data, klass = nil)
      return if data.nil?
      value = klass.nil? ? data : klass.new(data)
      instance_variable_set("@#{name.to_s}", value)
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
        instance_variable_set("@#{key}", value)
      end
    end
	end
end