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