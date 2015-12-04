# [Shipping Methods examples](https://developer.epages.com/apps/api-reference/resource-shipping-method.html)

This example assumes you have configured the `shop` correctly.

These calls returns an **Epages::ShippingMethod** instance. 


## [Shipping Methods call](https://developer.epages.com/apps/api-reference/get-shops-shopid-shipping-methods.html)

You can get the list of Shipping methods that the shop is using:
```
shipping_methods = shop.shipping_methods
```

You also can add a query parameter using:
```
shipping_methods = shop.shipping_methods(locale: "en_GB")
```

## [Shipping Method by id](https://developer.epages.com/apps/api-reference/get-shops-shopid-shipping-methods-shippingmethodid.html)

You can retrieve the information of a single shipping method **using its id or a instance of Epages::ShippingMethod**
```
using_id = shop.shipping_method("561E0DA0-91C0-4D12-79C6-D5809AB3231B")
using_instance = shop.shipping_method(shipping_method_instance)
```