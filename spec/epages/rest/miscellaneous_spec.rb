require 'spec_helper'

describe 'Epages::REST::Miscellaneous' do
  let(:token) { ENV['shop_token'] || IO.read('spec/fixtures/token.txt') }
  let(:shop_name) { ENV['shop_name'] || IO.read('spec/fixtures/shop_name.txt') }
  let(:shop) { Epages::REST::Shop.new(shop_name, token) }
  let(:fail_shop) { Epages::REST::Shop.new('non_existing_shop') }

  let(:json_products) { JSON.parse(File.read('spec/fixtures/products.json'))['items'] }
  let(:products) { json_products.collect { |p| Epages::Product.new(Epages::Utils.symbolize_keys!(p)) } }

  describe 'GET#locales' do
    let(:shop_locales) { shop.locales }
    it 'get the correct response' do
      expect(shop_locales).to be_a Hash
      expect(shop_locales).to have_key(:default)
      expect(shop_locales).to have_key(:items)
    end
  end

  describe 'GET#currencies' do
    let(:shop_locales) { shop.currencies }
    it 'get the correct response' do
      expect(shop_locales).to be_a Hash
      expect(shop_locales).to have_key(:default)
      expect(shop_locales).to have_key(:items)
    end
  end

  describe 'GET#product_suggestions_for' do
    let(:name) { products.first.name.split(' ').first }
    let(:shop_product_suggestions) { shop.product_suggestions_for(name) }
    it 'get the correct response' do
      expect(shop_product_suggestions).to be_a Array
      shop_product_suggestions.each do |p|
        expect(p).to be_a Epages::Product
        expect(p.name).to include name
      end
    end
  end
end
