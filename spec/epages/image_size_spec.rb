require 'spec_helper'

describe Epages::ImageSize do
  let(:images) { JSON.parse(File.read('spec/fixtures/image_size.json')) }
  let(:slide) { Epages::ImageSize.new(Epages::Utils.symbolize_keys!(images)) }

  describe '#methods' do
    it 'sizes' do
      expect(slide.sizes).to eq %w(Large Medium Small Thumbnail)
    end

    describe 'size_link' do
      it 'with existing size' do
        expect(slide.size_link('Small')).to eq 'https://pm.epages.com/WebRoot/Store/Shops/domingo/Products/vs_3202112018/vs_3202112018_s.jpg'
      end

      it 'with no existing size' do
        expect(slide.size_link('incorrect_size')).to eq nil
      end
    end
  end
end
