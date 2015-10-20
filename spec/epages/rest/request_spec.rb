require 'spec_helper'

describe 'Epages::REST::Request' do
  before do
    @shop = Epages::REST::Shop.new('shop_name', 'token')
    @other_shop = Epages::REST::Shop.new('other_shop')
    @options = {first_key: 'value1', secondKey: 'value2'}
  end

  describe '#create' do
    it 'GET request' do
      req = Epages::REST::Request.new(@shop, :get, '/path')

      expect(req.shop.name).to eq 'shop_name'
      expect(req.shop.token).to eq 'token'
      expect(req.uri.to_s).to eq 'https://pm.epages.com/rs/shops/shop_name/path'
      expect(req.path).to eq '/rs/shops/shop_name/path'
      expect(req.request_method).to eq :get
      expect(req.options).to be {}
      expect(req.headers['Accept']).to eq '*/*'
      expect(req.headers['Authorization']).to eq 'Token token'
      expect(req.headers['Content-Type']).to eq 'application/json'
    end

    it 'GET request with query parameters' do
      req = Epages::REST::Request.new(@other_shop, :get, '/path', @options)

      expect(req.options[:firstKey]).to eq 'value1'
      expect(req.options[:secondKey]).to eq 'value2'
      expect(req.headers['Authorization']).to be nil
    end
  end
end
