require 'spec_helper'

describe 'Epages::REST::Categories' do
  let(:token) { ENV['shop_token'] || IO.read('spec/fixtures/token.txt') }
  let(:shop_name) { ENV['shop_name'] || IO.read('spec/fixtures/shop_name.txt') }
  let(:shop_host) { ENV['shop_host'] || IO.read('spec/fixtures/shop_host.txt') }
  let(:shop) { Epages::REST::Shop.new(shop_host, shop_name, token) }
  let(:no_token_shop) { Epages::REST::Shop.new(shop_host, shop_name) }

  let(:json_categories) { JSON.parse(File.read('spec/fixtures/categories.json')) }
  let(:categories) { json_categories.collect { |c| Epages::Category.new(Epages::Utils.symbolize_keys!(c)) } }
  let(:category_id) { categories.first.sub_categories.first.href.split('/').last }

  let(:options) { {locale: 'en_US'} }

  describe 'GET#categories' do
    let(:shop_categories) { shop.categories }
    it 'get an array of categories' do
      shop_categories.each { |c| expect(c).to be_a Epages::Category }
      expect(shop_categories.first).to eq categories.first
    end
  end

  describe 'GET#category' do
    let(:category) { shop.category(category_id) }
    it 'get the correct category' do
      expect(category).to be_a Epages::Category
      expect(category.category_id).to eq category_id
    end
  end

  describe 'PUT#update_category' do
    let(:category) { shop.category(category_id) }
    it 'modifies the category' do
      tmp_data = {name: category.name, description: category.description}
      new_data = {name: 'New name', description: 'New description'}

      new_category_data = shop.update_category(category_id, new_data)
      expect(new_category_data.name).to eq new_data[:name]
      expect(new_category_data.description).to eq new_data[:description]

      shop.update_category(category_id, tmp_data) # restores the previous data
    end
  end
end
