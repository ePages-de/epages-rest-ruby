require 'spec_helper'

describe 'Epages::REST::Orders' do
  let(:token) { ENV['shop_token'] || IO.read('spec/fixtures/token.txt') }
  let(:shop_name) { ENV['shop_name'] || IO.read('spec/fixtures/shop_name.txt') }
  let(:shop_host) { ENV['shop_host'] || IO.read('spec/fixtures/shop_host.txt') }
  let(:shop) { Epages::REST::Shop.new(shop_host, shop_name, token) }
  let(:fail_shop) { Epages::REST::Shop.new(shop_host, 'non_existing_shop') }

  let(:number) { Random.rand(1000..50000).to_s }
  let(:shop_customer) { shop.create_customer }
  let(:shop_customer_with_number) { shop.create_customer(customer_number: number) }

  describe 'GET#customers' do
    let(:shop_customers) { shop.customers }

    it 'get an array of customers' do
      shop_customers.each { |p| expect(p).to be_a Epages::Customer }
    end
  end

  describe 'POST#create_customer' do
    it 'get the customer' do
      expect(shop_customer).to be_a Epages::Customer
      expect(shop_customer.customer_number).to be_a String
    end

    it 'get the the customer with specific customer_number' do
      expect(shop_customer_with_number).to be_a Epages::Customer
      expect(shop_customer_with_number.customer_number).to eq number
    end
  end

  describe 'GET#customer' do
    let(:shop_customer) { shop.customer(shop_customer_with_number) }
    it 'get the customer' do
      expect(shop_customer).to be_a Epages::Customer
      expect(shop_customer.customer_number).to eq number
    end
  end

  describe 'PATCH#update_customer' do
    let(:customer) { shop.create_customer }
    let(:note) { 'internal note' }
    it 'assigns attributes' do
      updated_customer = shop.update_customer(customer, 'internal_note' => note)
      expect(updated_customer.internal_note).to eq note
    end

    it 'removes attributes' do
      updated_customer = shop.update_customer(customer, remove: 'internal_note')
      expect(updated_customer.internal_note).to eq nil
    end
  end
end
