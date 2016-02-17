# [Sales Examples](https://developer.epages.com/apps/api-reference/resource-sales.html)

This example assumes you have configured the `shop` correctly.

# [Sales Call](https://developer.epages.com/apps/api-reference/get-shops-shopid-sales.html)

Returns the summary of sales for a specified product or for the shop grouped by currencies. 

```
general_sales = shop.sales
product_sales = shop.sales(product_id: product)
today_sales = shop.sales(created_after: Date.today)
sales_since = shop.sales(created_after: '24-01-2016')
```