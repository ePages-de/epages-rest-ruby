require 'spec_helper'

describe Epages::Shop do
  it 'attributes' do
    shop = Epages::Shop.new('shop', 'token')
    other = Epages::Shop.new('other')

    expect(shop.name).to eq 'shop'
    expect(shop.token).to eq 'token'
    expect(other.name).to eq 'other'
    expect(other.token).to be nil
  end

  it '#token_request?' do
    shop = Epages::Shop.new('shop', 'token')
    other = Epages::Shop.new('other')

    expect(shop.token_request?).to be true
    expect(other.token_request?).to be false
  end
end
