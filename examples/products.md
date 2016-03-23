# [Products examples](https://developer.epages.com/apps/api-reference/resource-product.html)

This example assumes you have configured the `shop` correctly.

The most part of these calls returns an **Epages::Product** instance. 
**Epages::Product** is an object that represents a single product of an ePages shop.
This class also implements some methods that allow you to access to the public attributes of the product and some methods to get extra information about the product using the API.
Between these methods are:
 * **[attribute]**: allows you to access to the [attribute] of the product. The full list of the attributes of the products are [here](https://developer.epages.com/apps/data-types.html#product).
 * **shop_name**: returns you the name of the shop.
 * **links_title**: give you the full list of additional information that you can get from the API. 
 * **link?**(link_name): returns you if the product has the link [link_name] as additional information.
 * **slideshow**: if the product has the link to the slideshow call, this method do the respective call to the API and retrieve the information.
 * **add_slideshow_image**: add an image to the slideshow, this method do the respective call to the API and retrieve the information.
 * **delete_slideshow_image**: removes an image from the slideshow and return the new slideshow, this method do the respective call to the API and retrieve the information.
 * **slideshow_sequence**: get the current slideshow sequence of images, this method do the respective call to the API and retrieve the information.
 * **update_slideshow_sequence**: update the sequence order of the slideshow and returns the new one. This method do the respective call to the API and retrieve the information.
 * **variations**: if the product has the link to the variations call, this method do the respective call to the API and retrieve the information.
 * **custom_attributes**: if the product has the link to the custom-attributes call, this method do the respective call to the API and retrieve the information.
 * **categories**: if the product has the link to the categories call, this method do the respective call to the API and retrieve the information.
 * **lowest_price**: if the product has the link to the lowest-price call, this method do the respective call to the API and retrieve the information.
 * **stock_level**: retrieves the stock level of the product from the API.
 * **change_stock_level**(quantity,shop): changes the stock level of the product in the quantity indicated as a parameter. Requires Authentication Token included in the shop`.
 * **to_line_item**(quantity): return a Hash with the product_id and the quantity. This method ease to put a product in a cart.

## [Products call](https://developer.epages.com/apps/api-reference/get-shops-shopid-products.html)

You can get the products of a shop using:
```
products = shop.products
```

You also can add a query parameter using:
```
sorted_products = shop.products(sort: "name")
sort_three_products = shop.products(sort: "name", results_per_page: 3)
```

## [Product by id](https://developer.epages.com/apps/api-reference/get-shops-shopid-products-productid.html)

You can retrieve the information of a single product **using the id** of the product **or a instance of Epages::Product**
```
using_id = shop.product("561E0DA0-91C0-4D12-79C6-D5809AB3231B")
using_product = shop.product(products.first)
```

## [Update Product](https://developer.epages.com/apps/api-reference/patch-shops-shopid-products-productid.html)

You can update the attributes of a single product **using the id** of the product **or a instance of Epages::Product** and a Hash of attributes to add or replace the attribute value or an Array indicating the attributes to be removed.
```
updated_product = shop.update_product(product, name: 'This is the new name', short_description: 'New short description', remove: ['manufacturer', 'upc', 'ean'])
``

## [Variations of a product](https://developer.epages.com/apps/api-reference/get-shops-shopid-products-productid-variations.html)

This call is used to get all the variations of a product, for example variations in sizes or colors. To get this variations:
```
variations = shop.product_variations(product)
product_variations = product.variations
```
 
This call returns you a Hash with the keys: 
 * **variation_attributes**: array of [Epages::VariationAttribute](https://developer.epages.com/apps/data-types.html#variationattribute). This class defines the methods:
   * **display_values**: returns an array with all the `display_values` of the attribute value.
   * **formatted_values**: returns an array with all the `values` of the value attribute.
 * **items**: array of [Epages::Variation](https://developer.epages.com/apps/data-types.html#variation). This class defines the methods:
   * **link**: returns the link of the product.
   * **product_id**: returns the id of the variation (different from the main product).
   * **properties**: returns a Hash with all the properties and their respective value.
   * **attributes**: alias for properties.
   
## [Slideshow of a product](https://developer.epages.com/apps/api-reference/get-shops-shopid-products-productid-slideshow.html)

This call is used to get all the collection of images associated associated with the product. To get this images:
```
slides = shop.product_slideshow(product)
product_slides = product.slideshow
```

This call returns an array of [Epages::ImageSize]. 
This class defines at the same time a list of [Epages::Image] in different sizes and provides the next methods:
 * **sizes**: returns the list of the available sizes.
 * **size_link**(size): return the url of the link with the size passed as a parameter.
 
##[Add image to slideshow](https://developer.epages.com/apps/api-reference/post-shops-shopid-products-productid-slideshow.html)

This call is uded to add a new image to the slideshow of a product.
```
shop.product_add_slideshow_image(product, 'path/to/image.jpg')
product.add_slideshow_image('path/to/image.jpg')
```

##[Delete image from slideshow](https://developer.epages.com/apps/api-reference/delete-shops-shopid-products-productid-slideshow-imagename.html)

This call is uded to delete an image from the slideshow of a product.
```
shop.product_delete_slideshow_image(product, 'image.jpg')
product.delete_slideshow_image('image.jpg')
```

##[Slideshow sequence](https://developer.epages.com/apps/api-reference/get-shops-shopid-products-productid-slideshow-sequence.html)

This call is uded to get the slideshow sequence of images.
```
shop.product_slideshow_sequence
product.slideshow_sequence
```

##[Update slideshow sequence](https://developer.epages.com/apps/api-reference/put-shops-shopid-products-productid-slideshow-sequence.html)

This call is uded to change the order of the slideshow sequence.
```
shop.product_update_slideshow_sequence(["new", "sequence", "of", "images"])
product.update_slideshow_sequence(["new", "sequence", "of", "images"])
```

## [Custom Attributes of a product](https://developer.epages.com/apps/api-reference/get-shops-shopid-products-productid-custom-attributes.html)

This call is used to get all the custom attributes associated with the product, like dimensions or weight. To get this attributes:
```
attributes = shop.product_custom_attributes(product)
product_attrs = product.custom_attributes
```

This call returns an array of [Epages::CustomAttribute].
This class defines also define the method:
 * **formatted_attributes**: return a Hash with the display value as key and an array with all the displayValue as value

## [Lowest Price of a product](https://developer.epages.com/apps/api-reference/get-shops-shopid-products-productid-lowest-price.html)

This call is used to get the lowest price of the product among all the variations. To get this lowest price:
```
price = shop.product_lowest_price(product)
product_price = product.lowest_price
```

This call returns a Hash with 2 keys:
 * **links**: array of links that contains the links to the product with the lowest price.
 * **price_info**: instance of [Epages::PriceInfo](https://developer.epages.com/apps/data-types.html#priceinfo)

## [Categories of a product](https://developer.epages.com/apps/api-reference/get-shops-shopid-products-productid-categories.html)

This call is used to get the categories that the product belongs to.
```
categories = shop.product_categories(product)
product_categories = product.categories
```

This call return an array of [Epages::Link] referring to the category url.
  
## [Product Stock](https://developer.epages.com/apps/api-reference/get-shops-shopid-products-productid-stock-level.html)

This call is used to get number of units in stock of the provided product.
```
stock_units = shop.product_stock_level(product)
stock = product.stock_level
```

This call return a Integer number.

## [Change Product Stock](https://developer.epages.com/apps/api-reference/put-shops-shopid-products-productid-stock-level.html)

This call is used to get number of units in stock of the provided product.
```
update_stock = shop.product_change_stock_level(product, 1)
new_stock = product.change_stock_level(1, shop) # the token to allow you to access your shop is inside the shop variable, so you need to provide it 
```

This call return a Integer number referring to the new stock.

## [Updated products by property](https://developer.epages.com/apps/api-reference/get-shops-shopid-products-updated-productproperty.html)

Returns all updated products together with the time of their last update.
```
stock_changes = shop.updated_products_by_property(:stocklevel)
yesterday = Date.today.prev_day.to_datetime.to_s # without activesupport / rails
yesterday = 1.day.ago.to_s # with activesupport / rails
yesterday_stock_changes = shop.updated_products_by_property(:stocklevel, changed_after: yesterday)
```



