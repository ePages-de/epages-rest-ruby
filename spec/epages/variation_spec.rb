require 'spec_helper'

describe Epages::Variation do
  let(:attrs) { {color: 'ExtremeBlue', size: 'M'} }
  let(:link) { Epages::Link.new(rel: 'variation', href: 'https://pm.epages.com/rs/shops/domingo/products/561E0DA0-F501-1487-FB27-D5809AB323FC') }
  let(:attribute_selection) { [{name: 'Color', value: 'ExtremeBlue'}, {name: 'Size', value: 'M'}] }
  let(:variation) { Epages::Variation.new(link: link, attribute_selection: attribute_selection) }
  describe '#methods' do
    it 'url' do
      expect(variation.url).to eq link.href
    end

    it 'product_id' do
      expect(variation.product_id).to eq '561E0DA0-F501-1487-FB27-D5809AB323FC'
    end

    it 'properties' do
      expect(variation.properties).to include(attrs)
    end

    it 'attributes' do
      expect(variation.attributes).to include(attrs)
    end
  end
end
