require 'spec_helper'

describe 'Epages::REST::ShippingMethods' do
  let(:token) { ENV['shop_token'] || IO.read('spec/fixtures/token.txt') }
  let(:shop_name) { ENV['shop_name'] || IO.read('spec/fixtures/shop_name.txt') }
  let(:shop) { Epages::REST::Shop.new(shop_name, token) }
  let(:fail_shop) { Epages::REST::Shop.new('non_existing_shop') }

  let(:shipping_methods_json) { JSON.parse(File.read('spec/fixtures/shipping_methods.json')) }
  let(:shipping_methods) { shipping_methods_json.collect { |p| Epages::ShippingMethod.new(Epages::Utils.symbolize_keys!(p)) } }

  describe 'GET#shipping_methods' do
    let(:shop_shipping_methods) { shop.shipping_methods }
    it 'get the correct response' do
      shop_shipping_methods.each { |p| expect(p).to be_a Epages::ShippingMethod }
    end
  end

  describe 'GET#shipping_method' do
    let(:shop_shipping_method) { shop.shipping_method(shipping_methods.first.shipping_method_id) }
    it 'get the correct response' do
      expect(shop_shipping_method).to be_a Epages::ShippingMethod
      expect(shop_shipping_method.shipping_method_id).to eq shipping_methods.first.shipping_method_id
      expect(shop_shipping_method.name).to eq shipping_methods.first.name
    end
  end
end
