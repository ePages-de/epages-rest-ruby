require 'spec_helper'

describe Epages::Product do
  let(:token) { ENV['shop_token'] || IO.read('spec/fixtures/token.txt') }
  let(:shop_name) { ENV['shop_name'] || IO.read('spec/fixtures/shop_name.txt') }
  let(:shop) { Epages::REST::Shop.new(shop_name, token) }
  let(:json_products) { JSON.parse(File.read('spec/fixtures/products.json'))['items'] }
  let(:products) { json_products.collect { |p| Epages::Product.new(Epages::Utils.symbolize_keys!(p)) } }
  let(:product) { products.first }
  describe '#methods' do
    describe '==' do
      it 'compare with the same product' do
        expect(products.first).to eq product
      end
      it 'compare with different product' do
        expect(products.last).to_not eq product
      end
    end

    describe 'shop_name' do
      it 'get the name of the shop' do
        expect(product.shop_name).to eq 'domingo'
      end
    end

    describe 'links_title' do
      it 'get the list of available links' do
        expect(product.links_title).to eq ['self', 'custom-attributes', 'variations', 'lowest-price', 'categories']
      end
    end

    describe 'link?' do
      it 'existing link' do
        expect(product.link?('variations')).to eq true
      end
      it 'non existing link' do
        expect(product.link?('no_existing_link')).to eq false
      end
    end

    describe 'to_line_item' do
      it 'without parameters' do
        expect(product.to_line_item[:productId]).to eq product.product_id
        expect(product.to_line_item[:quantity]).to eq 1
      end
      it 'with parameter' do
        expect(product.to_line_item(2)[:productId]).to eq product.product_id
        expect(product.to_line_item(2)[:quantity]).to eq 2
      end
    end

    # the rest of the methods are implicitly included in the rest/products_spec
  end
end
