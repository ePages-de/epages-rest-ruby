require 'spec_helper'

describe 'Epages::REST::Product' do
  before do
    @shop = Epages::REST::Shop.new('domingo', 'token')
    @fail_shop = Epages::REST::Shop.new('non_existing_shop')
  end

  describe '#products' do
    it 'get an array of products if the shop exists' do
      products = @shop.products
      products.each { |p| expect(p).to be_instance_of Epages::Product }
    end

    it 'get 404 error if the shop does not exist' do
      expect{@fail_shop.products}.to raise_error(Epages::Error::NotFound)
    end

    it 'get an array of products if the shop exists' do
      products = @shop.products
      other = @shop.products({resultsPerPage: 5})
    end
  end
end
