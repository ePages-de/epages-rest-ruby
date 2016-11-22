## 1.0.7
  * New Calls:

    * Epages::REST::Categories#`create_category`
    * Epages::REST::Categories#`subcategories`
    * Epages::REST::Categories#`reorder_subcategories`
    * Epages::REST::Categories#`delete_category`

  * Removed Calls:

    * Epages::REST::Products#`product_categories`

  * Other changes:

    * new attribute `deliveryPeriod`, to Epages::Product
    * new attribute `visible`, to Epages::Product
    * new class Epages::MinimumCart for the attribute `minCartValue` on Epages::Cart
    * new class Epages::TaxClass
    * new attributes `partiallyDispatchedOn`, `partiallyPaidOn` and `partiallyInvoicedOn`, to Epages::Order

## 1.0.6

 * New Calls:

    * Epages::REST::Shop#`customers`
    * Epages::REST::Shop#`create_product`
    * Epages::REST::Shop#`watched_products`
    * Epages::REST::Shop#`order_cart`
    * Epages::REST::Shop#`newsletters`
    * Epages::REST::Shop#`newsletter_subscribers`

 * Other changes:

    * new attributes `tax_class`, `stocklevel` to Epages::Product (only for requests with a token with products_write scope)
    * new attributes `watchers` to Epages::Product (only filled in watched_products call)
    * removed method `modify_order`, endpoint no longer supported in the API, please use `update_order` instead
    * removed method `product_stock_level`, endpoint no longer supported in the API, now `product` include stock level
    * removed method `product_change_stock_level`, endpoint no longer supported in the API, please use `update_product` instead

## 1.0.5

 * New Calls:

    * Epages::REST::Shop#`info`
    * Epages::REST::Shop#`updated_products_by_property`
    * Epages::REST::Shop#`create_customer`
    * Epages::REST::Shop#`customer`
    * Epages::REST::Shop#`update_customer`
    * Epages::REST::Shop#`update_order`

 * Other changes:

    * shop can receive an additional boolean attribute `https` to support https and http. Default to true.  
    * renamed attribute `cancelled_on` to `rejected_on` and attribute `shipped_on` to `delivered_on` within orders
    * renamed method `update_order` to `modify_order`. Now `update_order` will be managed by the method patch instead of put

## 1.0.4

 * New Calls:

    * Epages::REST::Shop#`update_product`
    * Epages::REST::Shop#`product_add_slideshow_image`
    * Epages::REST::Shop#`product_delete_slideshow_image`
    * Epages::REST::Shop#`product_slideshow_sequence`
    * Epages::REST::Shop#`product_update_slideshow_sequence`
    * Epages::REST::Shop#`sales`
    * Epages::REST::Shop#`parallel_calls`

 * Other changes:

    * new attributes `shipping_data` and `payment_data` to orders
    * replaced attribute `comment` with `customer_comment` and `internal_note`
    * added range filters `crated_before` and `created_after` to orders
    * dates and are interpreted as Datetime, before was String

