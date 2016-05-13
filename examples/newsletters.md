# [Newsletters examples](https://developer.epages.com/apps/api-reference/resource-newsletter-campaigns.html)

This example assumes you have configured the `shop` correctly.

## [Newsletters call](https://developer.epages.com/apps/api-reference/get-shops-shopid-newsletter-campaigns.html)

Return the newsletters of a shop as array of Epages::Newsletter

```
newsletters = shop.newsletters
```

## [Subscribers of a newsletter](https://developer.epages.com/apps/api-reference/get-shops-shopid-newsletter-campaigns-campaignid-subscribers.html)

Return the subscribers of a newsletter as array of Epages::Subscriber

```
newsletter = shop.newsletters.first
subscribers = shop.newsletter_subscribers(newsletter)
```