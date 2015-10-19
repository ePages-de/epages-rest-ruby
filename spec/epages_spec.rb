require 'spec_helper'

describe Epages do
  it 'has a version number' do
    expect(Epages::VERSION).not_to be nil
  end

  it 'check classes creation' do
    expect(Epages::Shop).to be Epages::Shop
    expect(Epages::REST::Products).to be Epages::REST::Products
  end
end
