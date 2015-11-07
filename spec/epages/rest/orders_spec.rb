require 'spec_helper'

describe 'Epages::REST::Orders' do
  # let(:token) { ENV['shop_token'] || IO.read('spec/fixtures/token.txt') }
  # let(:shop_name) { ENV['shop_name'] || IO.read('spec/fixtures/shop_name.txt') }
  # let(:shop) { Epages::REST::Shop.new(shop_name, token) }
  # let(:fail_shop) { Epages::REST::Shop.new('non_existing_shop') }
  #
  # let(:json_products) { JSON.parse(File.read('spec/fixtures/products.json'))['items'] }
  # let(:products) { json_products.collect { |p| Epages::Product.new(Epages::Utils.symbolize_keys!(p)) } }
  # let(:product) { products.first }

  describe 'GET#orders' do
    let(:shop_products) { shop.products }
    let(:shop_products_options) { shop.products(options) }

    it 'get an array of products if the shop exists' do
      shop_products.each { |p| expect(p).to be_a Epages::Product }
    end
  end

  describe 'GET#order' do
    it 'do the request passing product_id as String' do
      api_product = shop.product(product.product_id)
      expect(api_product).to eq product
    end
  end

  # describe 'PUT#order' do
  #   it 'get the variation' do
  #     variation = shop.product_variations(product)
  #     variation[:variation_attributes].each { |v| expect(v).to be_a Epages::VariationAttribute }
  #     variation[:items].each { |v| expect(v).to be_a Epages::Variation }
  #   end
  # end
end
