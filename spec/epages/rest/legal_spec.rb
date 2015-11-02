require 'spec_helper'
require 'pry'

describe 'Epages::REST::Categories' do
  let(:token) { ENV['shop_token'] || IO.read('spec/fixtures/token.txt') }
  let(:shop_name) { ENV['shop_name'] || IO.read('spec/fixtures/shop_name.txt') }
  let(:shop) { Epages::REST::Shop.new(shop_name, token) }
  let(:no_token_shop) { Epages::REST::Shop.new('domingo') }

  let(:options) { {locale: 'en_US'} }

  describe 'GET#legal' do
    let(:shop_legal) { shop.legal }
    it 'get the correct response' do
      expect(shop_legal).to be_a Hash
      expect(shop_legal[:contact_info]).to be_a Epages::ContentPageSummary
      expect(shop_legal[:contact_info].name).to be_a String
      expect(shop_legal[:privacy_policy]).to be_a Epages::ContentPageSummary
      expect(shop_legal[:privacy_policy].name).to be_a String
      expect(shop_legal[:terms_and_conditions]).to be_a Epages::ContentPageSummary
      expect(shop_legal[:terms_and_conditions].name).to be_a String
      expect(shop_legal[:rights_of_withdrawal]).to be_a Epages::ContentPageSummary
      expect(shop_legal[:rights_of_withdrawal].name).to be_a String
      expect(shop_legal[:shipping_info]).to be_a Epages::ContentPageSummary
      expect(shop_legal[:shipping_info].name).to be_a String
      shop_legal[:links].each { |l| expect(l).to be_a Epages::Link }
    end
  end

  describe 'GET#contact_info' do
    let(:contact_info) { shop.contact_info }
    it 'get the correct response' do
      expect(contact_info).to be_a Hash
      expect(contact_info[:name]).to be_a String
      expect(contact_info[:navigation_caption]).to be_a String
      expect(contact_info[:short_description]).to be_a String
      expect(contact_info[:description]).to be_a String
      expect(contact_info[:address]).to be_a String
      expect(contact_info[:email]).to be_a String
    end
  end

  describe 'PUT#updata_contact_info' do
    let(:contact_info) { shop.contact_info }
    it 'modifies the contact_info' do
      # TODO: add put tests, current Forbidden 403
      tmp_data = {description: contact_info[:description]}
      new_data = {description: 'New description text'}

      new_contact_info = shop.update_contact_info(new_data)
      expect(new_contact_info).to be_a Hash
      expect(new_contact_info.description).to eq new_data[:description]

      shop.update_contact_info(tmp_data) # restores the previous data
    end
  end

  describe 'GET#privacy_policy' do
    let(:privacy_policy) { shop.privacy_policy }
    it 'get the correct response' do
      expect(privacy_policy).to be_a Hash
      expect(privacy_policy[:name]).to be_a String
      expect(privacy_policy[:navigation_caption]).to be_a String
      expect(privacy_policy[:description]).to be_a String
    end
  end

  describe 'PUT#update_privacy_policy' do
    let(:privacy_policy) { shop.privacy_policy }
    it 'get the correct response' do
    end
  end

  describe 'GET#terms_and_conditions' do
    let(:terms_and_conditions) { shop.terms_and_conditions }
    it 'get the correct response' do
      expect(terms_and_conditions).to be_a Hash
      expect(terms_and_conditions[:name]).to be_a String
      expect(terms_and_conditions[:navigation_caption]).to be_a String
      expect(terms_and_conditions[:description]).to be_a String
    end
  end

  describe 'PUT#update_terms_and_conditions' do
    it 'get the correct response' do
    end
  end

  describe 'GET#rights_of_withdrawal' do
    let(:rights_of_withdrawal) { shop.rights_of_withdrawal }
    it 'get the correct response' do
      expect(rights_of_withdrawal).to be_a Hash
      expect(rights_of_withdrawal[:name]).to be_a String
      expect(rights_of_withdrawal[:navigation_caption]).to be_a String
      expect(rights_of_withdrawal[:description]).to be_a String
    end
  end

  describe 'PUT#update_rights_of_withdrawal' do
    it 'get the correct response' do
    end
  end

  describe 'GET#shipping_info' do
    let(:shipping_info) { shop.shipping_info }
    it 'get the correct response' do
      expect(shipping_info).to be_a Hash
      expect(shipping_info[:name]).to be_a String
      expect(shipping_info[:description]).to be_a String
    end
  end

  describe 'PUT#update_shipping_info' do
    it 'get the correct response' do
    end
  end
end
