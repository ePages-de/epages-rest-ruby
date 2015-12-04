# [Orders examples](https://developer.epages.com/apps/api-reference/resource-orders.html)

This example assumes you have configured the `shop` correctly.

## [Orders](https://developer.epages.com/apps/api-reference/get-shops-shopid-orders.html)

Returns a list of orders of the shop. Returns an instance of Epages::Order
   
```
orders = shop.orders
new_orders = shop.orders(viewed_on: false)
```

## [Order by id](https://developer.epages.com/apps/api-reference/get-shops-shopid-orders-orderid.html)

Returns a specific order indicated by the order_id or a Epages::Oroder instance. Returns an instance of Epages::Order
   
```
last_order = shop.orders.last
new_order = shop.order(order_id)
last_one = shop.order(last_order)
```

## [Update Order](https://developer.epages.com/apps/api-reference/put-shops-shopid-orders-orderid.html)

Updates a specific order indicated by the order_id or a Epages::Oroder instance. Returns an instance of Epages::Order
   
```
new_comment = 'This order is reviewed'
address = Epages::Address.new(first_name: 'Domingo', last_name: 'developer', street: 'Fake Street 123', zip_code: '20253', city: 'HH', country: 'DE')
updated_order = shop.update_order(order, comment: new_comment, billing_address: address)
```