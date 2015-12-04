# [Carts examples](https://developer.epages.com/apps/api-reference/resource-carts.html)

This example assumes you have configured the `shop` correctly.

All this calls returns an **Epages::Cart** instance.
**Epages::Cart** is an object that represents an ePages shop cart.

## [Cart post call](https://developer.epages.com/apps/api-reference/post-shops-shopid-carts.html)

This call creates a cart for the shop and returns a Epages::Shop instance.
Default options: 
 * currency: 'EUR'
 * taxType: 'GROSS'
 * locale: 'en_GB'
 * lineItems: []
 
```
default_cart = shop.create_cart
us_cart = shop.create_cart(currency: 'USD', locale: 'en_US')
```

##[Cart by id](https://developer.epages.com/apps/api-reference/get-shops-shopid-carts-cartid.html)

This call retrieve a specific cart using its ID or **Epages::Cart** instance. Returns a Epages::Shop instance
```
cart = shop.cart("561E0DA0-91C0-4D12-79C6-D5809AB3231B")
```

## [Add line_item to cart](https://developer.epages.com/apps/api-reference/post-shops-shopid-carts-cartid-line-items.html)

This call add a line_item to the cart, and returns the instance of the Epages::Cart updated with the product.
The default quantity of the product is 1. To change it, add a third parameter.
This method has the alias **add_product_to_cart** to ease the syntax of the code.
```
updated_cart = shop.cart_line_item(old_cart, product)
updated_cart = shop.add_product_to_cart(updated_cart, another_product, 3)
```

## [Update a line_item](https://developer.epages.com/apps/api-reference/put-shops-shopid-carts-cartid-line-items-lineitemid.html)

This call modifies a specified product line_item in a cart indicated by the line_item id or a Epages::LineItem instance. Returns the updated Epages::Cart instance.
```
cart = shop.update_cart_line_item(old_cart, lineitem, quantity: 3)
```

## [Delete a line_item](https://developer.epages.com/apps/api-reference/delete-shops-shopid-carts-cartid-line-items-lineitemid.html)

This call deletes a specified product line_item in a cart indicated by the line_item id or a Epages::LineItem instance. Returns the updated Epages::Cart instance.
```
cart = shop.delete_cart_line_item(old_cart, lineitem)
```

## [Update Billing Address](https://developer.epages.com/apps/api-reference/put-shops-shopid-carts-cartid-billing-address.html) and [Update Shipping Address](https://developer.epages.com/apps/api-reference/put-shops-shopid-carts-cartid-shipping-address.html)

This call updates addresses of the cart with the Epages::Address instance indicated. Returns the updated Epages::Cart instance.
```
address_data = {firstName: 'Domingo', lastName: 'Cividanes', street: 'Fake Street', zipCode: 20_253, city: 'HH', country: 'GE', emailAddress: 'dcividanes91@gmail.com'}
address = Epages::Address.new(address_data)
cart = shop.update_cart_billing_address(old_cart, address)
cart = shop.update_cart_shipping_address(cart, address)
```

## [Delete Billing Address](https://developer.epages.com/apps/api-reference/delete-shops-shopid-carts-cartid-billing-address.html) and [Delete Shipping Address](https://developer.epages.com/apps/api-reference/delete-shops-shopid-carts-cartid-shipping-address.html)

This call deletes addresses of the car adn returns the updated Epages::Cart instance.
```
cart = shop.delete_billing_address(old_cart)
cart = shop.delete_shipping_address(cart)
```