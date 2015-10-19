require 'spec_helper'
require 'pry'

describe Epages do
  it 'has a version number' do
    expect(Epages::VERSION).not_to be nil
  end

  it 'check classes can be created without errors' do
    expect(Epages::Shop).to be Epages::Shop
    expect(Epages::Product).to be Epages::Product
    expect(Epages::Error).to be Epages::Error
    expect(Epages::REST::Products).to be Epages::REST::Products
    expect(Epages::REST::Shop).to be Epages::REST::Shop
  end

  it 'create rest shops successfully' do
    shop1 = Epages::REST::Shop.new('shop_name', 'token')
    shop2 = Epages::REST::Shop.new('shop_name')

    expect(shop1.name).to eq 'shop_name'
    expect(shop1.token).to eq 'token'

    expect(shop2.name).to eq 'shop_name'
    expect(shop2.token).to be nil
  end

  it 'create rest requests successfully' do
    shop1 = Epages::REST::Shop.new('shop_name', 'token')
    shop2 = Epages::REST::Shop.new('shop_name')
    options = {key1: 'value1', key2: 'value2'}

    request1 = Epages::REST::Request.new(shop1, :get, '/path', options)
    request2 = Epages::REST::Request.new(shop2, :get, '/path')

    expect(request1.shop.name).to eq 'shop_name'
    expect(request1.shop.token).to eq 'token'
    expect(request1.uri.to_s).to eq 'https://pm.epages.com/rs/shops/shop_name/path'
    expect(request1.path).to eq '/rs/shops/shop_name/path'
    expect(request1.options[:key1]).to eq 'value1'
    expect(request1.options[:key2]).to eq 'value2'
    expect(request1.request_method).to eq :get
    expect(request1.headers['Accept']).to eq '*/*'
    expect(request1.headers['Authorization']).to eq 'Token token'
    expect(request1.headers['Content-Type']).to eq 'application/json'

    expect(request2.shop.name).to eq 'shop_name'
    expect(request2.shop.token).to be nil
    expect(request2.uri.to_s).to eq 'https://pm.epages.com/rs/shops/shop_name/path'
    expect(request2.path).to eq '/rs/shops/shop_name/path'
    expect(request2.options).to be {}
    expect(request2.request_method).to eq :get
    expect(request2.headers['Accept']).to eq '*/*'
    expect(request2.headers['Authorization']).to be nil
    expect(request2.headers['Content-Type']).to eq 'application/json'
  end

  it 'shops receives 200, with or without token for public calls' do
    good_shop = Epages::REST::Shop.new('domingo', 'token')
    fail_shop = Epages::REST::Shop.new('domingo')

    expect(good_shop.products).to be_instance_of Array
    expect(fail_shop.products).to be_instance_of Array
  end
end
