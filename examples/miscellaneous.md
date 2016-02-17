# [Miscellaneous examples](https://developer.epages.com/apps/api-reference/resource-miscellaneous.html)

This example assumes you have configured the `shop` correctly.

## [Currencies](https://developer.epages.com/apps/api-reference/get-shops-shopid-currencies.html)

Retrieve the currency information of a shop. Returns a Hash with the keys:
 * default: The default currency of the shop
 * items: The list of all available currencies of the shop

```
currency_data = shop.currencies
```

## [Locales](https://developer.epages.com/apps/api-reference/get-shops-shopid-locales.html)

Returns the shop’s locale information, i.e. the language identifier and the region identifier. Returns a Hash with the keys:
 * default: The default locale of the shop
 * items: The list of all available locales of the shop

```
locales_data = shop.locales
```

## [Product Suggestion](https://developer.epages.com/apps/api-reference/get-shops-shopid-search-product-suggest.html)

Returns suggestions for a product search query. Returns an Array of Epages::Product.

```
jackets = shop.product_suggestions_for("Jacket")
top = shop.product_suggestions_for("Jacket", limit: 5)
```

## Parallel calls

Run the calls in different threads and return the responses in the same order as it was called. 
The keys must be the same that the name of the method to call. If you want to call multiple times tha same call with different parameters put every collection as an array element

```
requests = {
    products: {},
    categories: {locale: 'en_GB'},
    create_cart: {currency: 'USD', locale: 'en_US'},
}
product_requests = {
    products: [{sort: 'name', results_per_page: 2}, {results_per_page: 1, page: 3}],
}

response = shop.parallel_calls(requests)          # => { products: products_response, categories: categories_response, create_cart: create_cart_response }
product_response = shop.parallel_calls(requests)  # => { products: [products_response_1, products_response_2] }
```