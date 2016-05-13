require 'spec_helper'

describe 'Epages::REST::Newsletters' do
  let(:token) { ENV['shop_token'] || IO.read('spec/fixtures/token.txt') }
  let(:shop_name) { ENV['shop_name'] || IO.read('spec/fixtures/shop_name.txt') }
  let(:shop_host) { ENV['shop_host'] || IO.read('spec/fixtures/shop_host.txt') }
  let(:shop) { Epages::REST::Shop.new(shop_host, shop_name, token) }
  let(:shop_newsletters) { shop.newsletters }
  let(:newsletter) { shop_newsletters.first }

  describe 'GET#newsletters' do
    it 'get an array of newsletters' do
      shop_newsletters.each { |n| expect(n).to be_a Epages::Newsletter }
    end

    it 'the newsletter have the proper attributes' do
      newsletter = shop_newsletters.first
      expect(newsletter.id).to be_a String
      expect(newsletter.number_of_subscribers).to be_a Integer
      expect(newsletter.name).to be_a String
    end
  end

  describe 'GET#newsletter_subscribers' do
    let(:subscribers) { shop.newsletter_subscribers(newsletter) }
    it 'get an array of subscribers' do
      subscribers.each { |n| expect(n).to be_a Epages::Subscriber }
    end

    it 'the subscriber have the proper attributes' do
      subscriber = subscribers.first
      expect(subscriber.name).to be_a String
      expect(subscriber.email).to be_a String
      expect(subscriber.subscribed).to be_truthy
    end
  end
end