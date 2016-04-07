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
    
