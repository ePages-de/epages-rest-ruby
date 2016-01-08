require 'spec_helper'

describe 'Epages::REST::Shop' do
  describe '#parallel_calls' do
    let(:token) { ENV['shop_token'] || IO.read('spec/fixtures/token.txt') }
    let(:shop_name) { ENV['shop_name'] || IO.read('spec/fixtures/shop_name.txt') }
    let(:shop_host) { ENV['shop_host'] || IO.read('spec/fixtures/shop_host.txt') }
    let(:shop) { Epages::REST::Shop.new(shop_host, shop_name, token) }

    it 'different requests' do
      requests = {
        products: {},
        categories: {locale: 'en_GB'},
        create_cart: {currency: 'USD', locale: 'en_US'},
      }

      response = shop.parallel_calls(requests)
      response[:products].each { |p| expect(p).to be_a Epages::Product }
      response[:categories].each { |p| expect(p).to be_a Epages::Category }
      expect(response[:create_cart]).to be_a Epages::Cart
    end

    it 'array of same calls with different options' do
      requests = {
        products: [{sort: 'name', results_per_page: 2}, {results_per_page: 1, page: 3}],
      }

      response = shop.parallel_calls(requests)
      expect(response[:products][0].size).to eq 2
      expect(response[:products][1].size).to eq 1
    end
  end
end
