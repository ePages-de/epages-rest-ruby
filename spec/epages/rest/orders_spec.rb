require 'spec_helper'

describe 'Epages::REST::Orders' do
  let(:token) { ENV['shop_token'] || IO.read('spec/fixtures/token.txt') }
  let(:shop_name) { ENV['shop_name'] || IO.read('spec/fixtures/shop_name.txt') }
  let(:shop) { Epages::REST::Shop.new(shop_name, token) }
  let(:fail_shop) { Epages::REST::Shop.new('non_existing_shop') }

  let(:json_orders) { JSON.parse(File.read('spec/fixtures/orders.json'))['items'] }
  let(:orders) { json_orders.collect { |p| Epages::Order.new(Epages::Utils.symbolize_keys!(p)) } }
  let(:order) { orders.first }

  let(:options) { {viewed_on: true} }

  describe 'GET#orders' do
    let(:shop_orders) { shop.orders }
    let(:shop_orders_options) { shop.orders(options) }

    it 'get an array of orders if the shop exists' do
      shop_orders.each { |o| expect(o).to be_a Epages::Order }
    end

    it 'get the proper orders when options are passed' do
      shop_orders_options.each do |o|
        expect(o.viewed_on).to_not eq nil
      end
    end
  end

  describe 'GET#order' do
    let(:shop_order) { shop.order(order) }
    it 'do the request passing product_id as String' do
      expect(shop_order.order_id).to eq order.order_id
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
