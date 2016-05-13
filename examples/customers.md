# [Customers examples](https://developer.epages.com/apps/api-reference/resource-customers.html)

This example assumes you have configured the `shop` correctly.

## [Customers](https://developer.epages.com/apps/api-reference/get-shops-shopid-customers.html)

Returns a list of customers of the shop.
   
```
customers = shop.customers
```

## [Create Customer](https://developer.epages.com/apps/api-reference/post-shops-shopid-customers.html)

Creates a customer. If customerNumber is not provided in the request, it will be generated automatically. Returns an instance of Epages::Customer
   
```
new_customer = shop.create_customer
customer_1007 = shop.create_customer(customer_number: "1007")
```

## [Customer by id](https://developer.epages.com/apps/api-reference/get-shops-shopid-orders-orderid.html)

Returns a specific order indicated by the order_id or a Epages::Oroder instance. Returns an instance of Epages::Order
   
```
customer = shop.customer(customer)
other_customer = shop.customer(customer_id)
```

## [Update Customer](https://developer.epages.com/apps/api-reference/patch-shops-shopid-customers-customerid.html)

Updates a specific customer indicated by the customer_id or a Epages::Customer instance. Returns an instance of Epages::Customer
   
```
new_comment = 'This order is reviewed'
address = Epages::Address.new(first_name: 'Domingo', last_name: 'developer', street: 'Fake Street 123', zip_code: '20253', city: 'HH', country: 'DE')
updated_customer = shop.update_customer(customer, internal_note: new_comment, billing_address: address)
updated_customer2 = shop.update_customer(updated_customer, remove: 'internal_note')
```