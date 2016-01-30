require 'spec_helper'

describe 'Epages::REST::Sales' do
  let(:token) { ENV['shop_token'] || IO.read('spec/fixtures/token.txt') }
  let(:shop_name) { ENV['shop_name'] || IO.read('spec/fixtures/shop_name.txt') }
  let(:shop_host) { ENV['shop_host'] || IO.read('spec/fixtures/shop_host.txt') }
  let(:shop) { Epages::REST::Shop.new(shop_host, shop_name, token) }
  let(:fail_shop) { Epages::REST::Shop.new(shop_host, 'non_existing_shop') }
  let(:product) { shop.product('561E0D9E-5800-58C2-5135-D5809AB323D4') }

  describe 'GET#Sales' do
    let(:shop_sales) { shop.sales }
    let(:shop_sales_options) { shop.sales created_after: '28-01-2016', product: product }

    it 'get an array of sales' do
      shop_sales.each { |p| expect(p).to be_a Epages::Sale }
    end

    it 'with parameters' do
      expect(shop_sales_options.size).to eq 2
    end
  end
end