require 'spec_helper'

describe 'Epages::REST::Products' do
  let(:token) { ENV['shop_token'] || IO.read('spec/fixtures/token.txt') }
  let(:shop_name) { ENV['shop_name'] || IO.read('spec/fixtures/shop_name.txt') }
  let(:shop_host) { ENV['shop_host'] || IO.read('spec/fixtures/shop_host.txt') }
  let(:shop) { Epages::REST::Shop.new(shop_host, shop_name, token) }
  let(:fail_shop) { Epages::REST::Shop.new(shop_host, 'non_existing_shop') }

  let(:json_products) { JSON.parse(File.read('spec/fixtures/products.json'))['items'] }
  let(:products) { json_products.collect { |p| Epages::Product.new(Epages::Utils.symbolize_keys!(p)) } }
  let(:product) { products.first }
  let(:slideshow_product) { products.find { |p| p.link?('slideshow') } }
  let(:no_slideshow_product) { products.find { |p| !p.link?('slideshow') } }
  let(:custom_attr_product) { products.find { |p| p.link?('custom-attributes') } }
  let(:no_custom_attr_product) { products.find { |p| !p.link?('custom-attributes') } }
  let(:lowest_price_product) { products.find { |p| p.link?('lowest-price') } }

  let(:options) { {resultsPerPage: 1} }
  let(:sequence) { shop.product_slideshow_sequence(slideshow_product) }

  describe 'GET#products' do
    let(:shop_products) { shop.products }
    let(:shop_products_options) { shop.products(options) }

    it 'get an array of products if the shop exists' do
      shop_products.each { |p| expect(p).to be_a Epages::Product }
    end

    it 'get 404 error if the shop does not exist' do
      expect { fail_shop.products }.to raise_error(Epages::Error::NotFound)
    end

    it 'accepts query parameters' do
      expect(shop_products.count).to eq 10
      expect(shop_products_options.count).to eq 1
    end
  end

  describe 'GET#product' do
    it 'do the request passing product_id as String' do
      api_product = shop.product(product.product_id)
      expect(api_product).to eq product
    end

    it 'do the request passing product_id as Epages::Product' do
      api_product = shop.product(product)
      expect(api_product).to eq product
    end
  end

  describe 'PATCH#product' do
    let(:name) { product.name }
    let(:short_description) { product.short_description }
    let(:price) { product.price_info.price.amount }
    it 'removes attributes' do
      api_product = shop.update_product(product, remove: 'short_description')
      expect(api_product.short_description).to eq nil
    end

    it 'assigns attributes' do
      api_product = shop.update_product(product, 'name' => name, 'short_description' => short_description, 'price_info/price/amount' => price)
      expect(api_product.name).to eq name
      expect(api_product.short_description).to eq short_description
      expect(api_product.price_info.price.amount).to eq price
    end
  end

  describe 'GET#product_variations' do
    it 'get the variation' do
      variation = shop.product_variations(product)
      variation[:variation_attributes].each { |v| expect(v).to be_a Epages::VariationAttribute }
      variation[:items].each { |v| expect(v).to be_a Epages::Variation }
    end
  end

  describe 'GET#product_slideshow' do
    it 'get the slideshow' do
      slideshow = shop.product_slideshow(slideshow_product)
      slideshow.each do |i|
        expect(i).to be_a Epages::ImageSize
        i.images.each { |s| expect(s).to be_a Epages::Image }
      end
    end
  end

  describe 'POST#slideshow_image' do
    it 'post a new image' do
      slideshow = shop.product_add_slideshow_image(slideshow_product, 'spec/fixtures/test.png')
      expect(slideshow.name).to eq 'test.png'
    end
  end

  describe 'DELETE#slideshow_image' do
    it 'delete a image' do
      slideshow = shop.product_delete_slideshow_image(slideshow_product, 'test.png')
      expect(slideshow).to eq nil # the response throws a HTTP: 204 but without any body, otherwise error
    end
  end

  describe 'GET#product_slideshow_sequence' do
    it 'get the sequence' do
      sequence = shop.product_slideshow_sequence(slideshow_product)
      expect(sequence).to be_a Array
    end
  end

  describe 'PUT#product_slideshow_sequence' do
    it 'put the new sequence' do
      new_sequence = shop.product_update_slideshow_sequence(slideshow_product, sequence.rotate)
      expect(new_sequence).to be_a Array
      expect(new_sequence).to eq sequence.rotate
      shop.product_update_slideshow_sequence(slideshow_product, sequence)
    end
  end

  describe 'GET#product_custom_attributes' do
    it 'get the custom_attributes' do
      custom_attributes = shop.product_custom_attributes(custom_attr_product)
      custom_attributes.each { |ca| expect(ca).to be_a Epages::CustomAttribute }
    end
  end

  describe 'GET#product_lowest_price' do
    it 'get lowest price' do
      lowest_price = shop.product_lowest_price(lowest_price_product)
      expect(lowest_price).to be_a Hash
      expect(lowest_price).to have_key(:links)
      expect(lowest_price).to have_key(:price_info)
      expect(lowest_price[:price_info]).to be_a Epages::PriceInfo
      lowest_price[:links].each { |l| expect(l).to be_a Epages::Link }
    end
  end

  describe 'GET#product_categories' do
    it 'get the categories' do
      categories = shop.product_categories(product)
      categories.each { |c| expect(c).to be_a Epages::Link }
    end
  end

  describe 'GET#product_stock_level' do
    it 'get the stock level' do
      stock_level = shop.product_stock_level(product)
      expect(stock_level).to be_a Float
    end
  end

  describe 'PUT#product_change_stock_level' do
    it 'change the current stock level' do
      stock_level = shop.product_change_stock_level(product, 1)
      expect(stock_level).to be_a Float
    end
  end

  describe 'GET#updated_products_by_property' do
    let(:sales) { shop.updated_products_by_property(:stocklevel, changed_after: Date.today.prev_day.to_datetime.to_s) }
    it 'get the array of products' do
      sales.each { |p| expect(p).to be_a Epages::Product }
    end
  end

  # TODO: needed a specific app not launched yet
  #
  # describe 'GET#export_products' do
  #   it 'get the csv' do
  #     export = shop.export_products
  #     expect(export).to be_a String
  #   end
  # end
end
