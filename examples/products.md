# [Products examples](https://developer.epages.com/apps/api-reference/resource-product.html)

This example assumes you have configured the `shop` correctly.

The most part of these calls returns an **Epages::Product** instance. 
**Epages::Product** is an object that represents a single product of an ePages shop.
This class also implements some methods that allow you to access to the public attributes of the product and some methods to get extra information about the product using the API.
Between these methods are:
 * **[attribute]**: allows you to access to the [attribute] of the product. The full list of the attributes of the products are [here](https://developer.epages.com/apps/data-types.html#product).
 * **shop_name**: returns you the name of the shop.
 * **links_title**: give you the full list of additional information that you can get from the API. 
 * **link?(link_name)**: returns you if the product has the link [link_name] as additional information.
 * **slideshow**: if the product has the link to the slideshow call, this method do the respective call to the API and retrieve the information.
 * **variations**: if the product has the link to the variations call, this method do the respective call to the API and retrieve the information.
 * **custom_attributes**: if the product has the link to the custom-attributes call, this method do the respective call to the API and retrieve the information.
 * **categories**: if the product has the link to the categories call, this method do the respective call to the API and retrieve the information.
 * **lowest_price**: if the product has the link to the lowest-price call, this method do the respective call to the API and retrieve the information.
 * **stock_level**: retrieves the stock level of the product from the API.
 * **change_stock_level_in(quantity)**: changes the stock level of the product in the quantity indicated as a parameter. Requires Authentication Token included in the shop`.
 * **to_line_item(quantity)**: return a Hash with the product_id and the quantity. This method ease to put a product in a cart.

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

## [Variations of a product](https://developer.epages.com/apps/api-reference/get-shops-shopid-products-productid-variations.html)

Some products have variations in sizes or colors. To get this variations:
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

Some products have a collection of images associated. To get this images:
```
slides = shop.product_slideshow(product)
product_slides = product.slideshow
```

This call returns an array of [Epages::ImageSize]. 
This class defines at the same time a list of [Epages::Image] in different sizes and provides the next methods:
 * **sizes**: returns the list of the available sizes.
 * **size_link**(size): return the url of the link with the size passed as a parameter.
