require 'spec_helper'

describe Epages::CustomAttribute do
  let(:attrs) { {key: 'Preview', display_key: 'Preview', single_value: true, type: 'url', values: [{value: 1, displayValue: 'value1'}, {value: 2, displayValue: 'value2'}]} }
  let(:custom_attribute) { Epages::CustomAttribute.new(attrs) }
  describe '#methods' do
    it 'formatted_attributes' do
      expect(custom_attribute.formatted_attributes).to have_key(:preview)
      expect(custom_attribute.formatted_attributes[:preview]).to eq %w(value1 value2)
    end
  end
end
