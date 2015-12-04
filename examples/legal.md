# [Legal examples](https://developer.epages.com/apps/api-reference/resource-legal.html)

This example assumes you have configured the `shop` correctly.

## [Legal call](https://developer.epages.com/apps/api-reference/get-shops-shopid-legal.html)

Retrieves the legal information for a shop. Returns a Hash with the keys contact_info, privacy_policy, terms_and_conditions, rights_of_withdrawal, shipping_information
as instances of Epages::ContentPageSummary and a links key that is an array that contains the link to the shop legal information. Each link of the array is an instance of Epages::Link.
   
```
legal_info = shop.legal
english_legal = shop.legal(locale: "en_GB")
```

## [Contact Information](https://developer.epages.com/apps/api-reference/get-shops-shopid-legal-contact-information.html) and [Update Contact Information](https://developer.epages.com/apps/api-reference/put-shops-shopid-legal-contact-information.html)

This call retrieves the contact information of a shop. Returns a Hash.
```
contact = shop.contact_info
english_contact = shop.contact_info(locale: "en_GB")
```

You can also update this information, using the update call.
```
new_info = {description: 'The new description of the shop', email: 'dcividanes91@gmail.com' }
german_info = {description: 'deutsche Informationen', email: 'dcividanes@epages.com'}
shop.update_contact_info(new_info)
shop.update_contact_info(new_info, "de_DE")
```

This same example is valid with other legal methods.
 * [Privacy Policy](https://developer.epages.com/apps/api-reference/get-shops-shopid-legal-privacy-policy.html): `shop.privacy_policy`
 * [Update Privacy Policy](https://developer.epages.com/apps/api-reference/put-shops-shopid-legal-privacy-policy.html): `shop.update_privacy_policy`
 * [Terms and Conditions](https://developer.epages.com/apps/api-reference/get-shops-shopid-legal-terms-and-conditions.html): `shop.terms_and_conditions`
 * [Update Terms and Conditions](https://developer.epages.com/apps/api-reference/put-shops-shopid-legal-terms-and-conditions.html): `shop.update_terms_and_conditions`
 * [Rights of Withdrawal](https://developer.epages.com/apps/api-reference/get-shops-shopid-legal-rights-of-withdrawal.html): `shop.rights_of_withdrawal`
 * [Update Rights of Withdrawal](https://developer.epages.com/apps/api-reference/put-shops-shopid-legal-rights-of-withdrawal.html): `shop.update_rights_of_withdrawal`
 * [Shipping Information](https://developer.epages.com/apps/api-reference/get-shops-shopid-legal-shipping-information.html): `shop.shipping_info`
 * [Update Shipping Information](https://developer.epages.com/apps/api-reference/put-shops-shopid-legal-shipping-information.html): `shop.update_shipping_info`
