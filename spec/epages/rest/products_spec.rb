require 'spec_helper'
require 'pry'

describe 'Epages::REST::Product' do
  before do
    @shop = Epages::REST::Shop.new('domingo', 'token')
    @fail_shop = Epages::REST::Shop.new('non_existing_shop')
    @options = {resultsPerPage: 1}
    @product = @shop.products.first
  end

  describe 'GET#products' do
    it 'get an array of products if the shop exists' do
      products = @shop.products
      products.each { |p| expect(p).to be_instance_of Epages::Product }
    end

    it 'get 404 error if the shop does not exist' do
      expect { @fail_shop.products }.to raise_error(Epages::Error::NotFound)
    end

    it 'accepts query parameters' do
      products = @shop.products
      other = @shop.products(@options)

      expect(products.count).to eq 10
      expect(other.count).to eq 1
    end
  end

  describe 'GET#product' do
    it 'do the request passing product_id as String' do
      product = @shop.product(@product.product_id)
      expect(@product).to eq product
    end

    it 'do the request passing product_id as Epages::Product' do
      product = @shop.product(@product)
      expect(@product).to eq product
    end
  end
end
