require 'spec_helper'
require 'pry'

describe 'Epages::REST::Product' do
  before do
    @shop = Epages::REST::Shop.new('domingo', 'token')
    @fail_shop = Epages::REST::Shop.new('non_existing_shop')
    @options = {resultsPerPage: 1}
    @products = @shop.products
    @product = @products.first
    @slideshow_product = @products.find {|p| p.relative_link("slideshow") }
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

  describe 'GET#product_variations' do
    it 'get the variation' do
      variation = @shop.product_variations(@product.product_id)
      expect(variation[:variation_attributes].first).to be_instance_of Epages::VariationAttribute
      expect(variation[:items].first).to be_instance_of Epages::Variation
    end
  end

  describe 'GET#product_slideshow' do
    it 'get the slideshow' do
      # TODO: wait for data types 
      slideshow = @shop.product_slideshow(@slideshow_product.product_id)
      expect(true).to eq false
    end
  end

  describe 'GET#product_custom_attributes' do
    it 'get the custom_attributes' do
      custom_attributes = @shop.product_custom_attributes(@product.product_id)
      expect(custom_attributes.first).to be_instance_of Epages::CustomAttribute
    end
  end

  describe 'GET#product_lowest_price' do
    it 'get lowest price' do
      # TODO: add lowest price product in mbo
      lowest_price = @shop.product_custom_attributes(@product.product_id)
      expect(true).to eq false
    end
  end

  describe 'GET#product_categories' do
    it 'get the categories' do
      categories = @shop.product_categories(@product.product_id)
      expect(categories.first).to be_instance_of Epages::Link
    end
  end

  describe 'GET#product_stock_level' do
    it 'get the stock level' do
      stock_level = @shop.product_stock_level(@product.product_id)
      expect(stock_level).to have_key(:stocklevel)
    end
  end

  describe 'PUT#change_product_stock_level' do
    it 'change the current stock level' do
      # TODO: ask for token
      stock_level = @shop.change_product_stock_level(@product.product_id, {"changeStocklevel": -1})
      expect(true).to eq false
    end
  end

  describe 'GET#export_products' do
    it 'get the csv' do
      # TODO: ?????
      stock_level = @shop.export_products
      expect(true).to eq false
    end
  end
end
