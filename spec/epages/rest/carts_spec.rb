require 'spec_helper'

describe 'Epages::REST::Carts' do
  let(:token) { ENV['shop_token'] || IO.read('spec/fixtures/token.txt') }
  let(:shop_name) { ENV['shop_name'] || IO.read('spec/fixtures/shop_name.txt') }
  let(:shop_host) { ENV['shop_host'] || IO.read('spec/fixtures/shop_host.txt') }
  let(:shop) { Epages::REST::Shop.new(shop_host, shop_name, token) }
  let(:fail_shop) { Epages::REST::Shop.new(shop_host, 'non_existing_shop') }

  let(:json_products) { JSON.parse(File.read('spec/fixtures/products.json'))['items'] }
  let(:products) { json_products.collect { |p| Epages::Product.new(Epages::Utils.symbolize_keys!(p)) } }

  let(:shop_cart) { shop.create_cart(line_items: products.shuffle.take(3).map(&:to_line_item)) }
  let(:empty_cart) { shop.create_cart }
  let(:address_data) { Epages::Address.new({firstName: 'Domingo', lastName: 'Cividanes', street: 'Fake Street', zipCode: 20_253, city: 'HH', country: 'GE', emailAddress: 'dcividanes91@gmail.com'}) }

  describe 'POST#carts' do
    it 'get the correct response' do
      expect(shop_cart).to be_a Epages::Cart
      expect(shop_cart.cart_id).to be_a String
      expect(shop_cart.checkout_url).to be_a String
      expect(shop_cart.billing_address).to eq nil
      expect(shop_cart.shipping_address).to eq nil
      expect(shop_cart.line_item_container).to be_a Epages::LineItemContainer
      expect(shop_cart.line_item_container.grand_total).to be_a Epages::Price
      shop_cart.line_item_container.product_line_items.each { |p| expect(p).to be_a Epages::ProductLineItem }
    end
  end

  describe 'GET#cart' do
    it 'get the correct response' do
      expect(shop_cart).to be_a Epages::Cart
      expect(shop_cart.cart_id).to eq shop_cart.cart_id
      expect(shop_cart.checkout_url).to be_a String
    end
  end

  describe 'POST#order_cart' do
    let(:cart) { shop.update_cart_billing_address(shop_cart, address_data) }
    let(:ordered_cart) { shop.order_cart(cart) }
    it 'get the correct response' do
      expect(ordered_cart).to be_a Epages::Order
      expect(ordered_cart.billing_address).to be_a Epages::Address
      expect(ordered_cart.creation_date).to be_a DateTime
      expect(ordered_cart.line_item_container).to be_a Epages::LineItemContainer
    end
  end

  describe 'Changing Cart LineItems' do
    let(:cart_with_li) { shop.cart_line_item(empty_cart, products.first) }
    let(:lineitem) { cart_with_li.line_item_container.product_line_items.first }
    let(:updated_cart) { shop.update_cart_line_item(empty_cart, lineitem, quantity: 3) }
    describe 'POST#cart_line_items' do
      it 'get the correct response' do
        expect(cart_with_li).to be_a Epages::Cart
        expect(cart_with_li.cart_id).to eq empty_cart.cart_id
        expect(cart_with_li.line_item_container.product_line_items.first.product_id).to eq products.first.product_id
      end
    end

    describe 'PUT#update_cart_line_items' do
      it 'get the correct response' do
        expect(updated_cart).to be_a Epages::Cart
        expect(updated_cart.cart_id).to eq empty_cart.cart_id
        expect(updated_cart.line_item_container.product_line_items.first.line_item_id).to eq lineitem.line_item_id
        expect(updated_cart.line_item_container.product_line_items.first.quantity[:amount]).to eq 3
      end
    end

    describe 'DELETE#delete_cart_line_item' do
      let(:no_li_cart) { shop.delete_cart_line_item(updated_cart, lineitem) }
      it 'get the correct response' do
        expect(updated_cart.line_item_container.product_line_items).to_not eq []
        expect(no_li_cart.line_item_container.product_line_items).to eq []
      end
    end
  end

  describe 'Changing Adresses' do
    let(:billing_cart) { shop.update_cart_billing_address(shop_cart, address_data) }
    let(:shipping_cart) { shop.update_cart_shipping_address(shop_cart, address_data) }
    describe 'PUT#update_billing_address' do
      it 'get the correct response' do
        expect(shop_cart.billing_address).to eq nil
        expect(billing_cart).to be_a Epages::Cart
        expect(billing_cart.billing_address).to be_a Epages::Address
      end
    end

    describe 'DELETE#delete_billing_address' do
      let(:deleted_address_cart) { shop.delete_cart_billing_address(billing_cart) }
      it 'get the correct response' do
        expect(billing_cart.billing_address).to be_a Epages::Address
        expect(deleted_address_cart.billing_address).to eq nil
      end
    end

    describe 'PUT#update_shipping_address' do
      it 'get the correct response' do
        expect(shop_cart.shipping_address).to eq nil
        expect(shipping_cart).to be_a Epages::Cart
        expect(shipping_cart.shipping_address).to be_a Epages::Address
      end
    end

    describe 'DELETE#delete_shipping_address' do
      let(:deleted_address_cart) { shop.delete_cart_shipping_address(shipping_cart) }
      it 'get the correct response' do
        expect(shipping_cart.shipping_address).to be_a Epages::Address
        expect(deleted_address_cart.shipping_address).to eq nil
      end
    end
  end
end
