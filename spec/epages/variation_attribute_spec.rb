require 'spec_helper'

describe Epages::VariationAttribute do
  let(:attributes) { {name: 'Color', display_name: 'Colour', values: [{value: 'Black', displayValue: 'Dark'}, {value: 'Blue', displayValue: 'Aqua'}]} }
  let(:variation_attributes) { Epages::VariationAttribute.new(attributes) }
  describe '#methods' do
    it 'formatted_values' do
      expect(variation_attributes.formatted_values).to eq %w(Black Blue)
    end

    it 'display_values' do
      expect(variation_attributes.display_values).to eq %w(Dark Aqua)
    end
  end
end
