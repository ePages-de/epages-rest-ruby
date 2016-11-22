# [Categories examples](https://developer.epages.com/apps/api-reference/resource-category.html)

This example assumes you have configured the `shop` correctly.

All this calls returns an **Epages::Category** instance.

## [Categories call](https://developer.epages.com/apps/api-reference/get-shops-shopid-categories.html)

Returns an array of Epages::Category instances corresponding to the shop categories.
```
categories = shop.categories
english_categories = shop.categories(locale: "en_GB")
```

##[Category by id](https://developer.epages.com/apps/api-reference/get-shops-shopid-categories-categoryid.html)

This call retrieve a specific category using its ID or **Epages::Category** instance. Returns a Epages::Category instance
```
category = shop.category(category_id)
```

## [Update Category data](https://developer.epages.com/apps/api-reference/put-shops-shopid-categories-categoryid.html)

This call modifies a specific category using its ID or **Epages::Category** instance. Returns a Epages::Category instance
```
new_data = {name: 'New name', description: 'New description'}
new_category_data = shop.update_category(category_id, new_data)
```