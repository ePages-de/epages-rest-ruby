require 'epages/shop'
require 'epages/rest/api'
require 'epages/rest/request'
require 'epages/rest/utils'

module Epages
  module REST
    class Shop < Epages::Shop
      include Epages::REST::API

      def parallel_calls(requests)
        threads = []
        result = requests
        requests.each do |key, values|
          values.each_with_index do |call, i|
            threads << (values.is_a?(Array) ? process_thread(key, call, i) : process_thread(key, values))
          end
        end
        threads.each do |t|
          t.join
          t[:index].nil? ? result[t[:name]] = t[:result] : result[t[:name]][t[:index]] = t[:result]
        end
        result
      end
    end
  end
end
