require 'spec_helper'

describe Epages::Shop do
  let(:shop) { Epages::Shop.new('host', 'shop', 'token') }
  let(:other) { Epages::Shop.new('host', 'other') }
  it 'attributes' do
    expect(shop.host).to eq 'host'
    expect(shop.name).to eq 'shop'
    expect(shop.token).to eq 'token'
    expect(other.name).to eq 'other'
    expect(other.token).to be nil
  end

  it 'shop_name' do
    expect(shop.shop_name).to eq 'shop'
  end

  it '#token?' do
    expect(shop.token?).to be true
    expect(other.token?).to be false
  end
end
