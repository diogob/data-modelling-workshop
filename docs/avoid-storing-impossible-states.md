# Avoid storing impossible states

## Why?

This one is quite intuitive. Managing state is a complex business. The number of possible states grows exponentially with the number of attributes. Cutting down on possible states makes it much easier to reason about the code and avoid writing code and tests to handle situations that are not allowed by the domain rules.

Some of these checks might even reduce security vulnerability, since sometimes malicious actors can use holes in the domain modelling to take advantage of the system. Think of an ecommerce system that allows the cart to receive negative quantities of a product and how this could lead to nefarious side-effects.

## How?

This is a more general principle than the ones seen so far. It actually comprises both previous topics. Having defined natural keys and removing null values you probably already removed several impossible states from the future of your database.

Knowing the more general principle underlying data modelling allow us to further eliminate impossible states [normalizing the schema](https://en.wikipedia.org/wiki/Database_normalization) and using [database custom types](https://www.postgresql.org/docs/current/sql-createtype.html).

## Exercise

As an exercise we will extend our model to include information on user subscriptions and payments.
Take the following rules into account:

* Each user might have several subscription, but only one of them is active at a time.
* Once a user creates a subscription, it cannot be removed only deactivated.
* Subscriptions always have a price that cannot be negative.
* Users can pay several times for the same subscription, the amount paid must always match exactly the subscription price.
* Users cannot pay for other users subscriptions.

Implement the roles above in your model without using any stored procdures.
Keep in mind that [check constraints](https://www.postgresql.org/docs/13/ddl-constraints.html#DDL-CONSTRAINTS-CHECK-CONSTRAINTS) and [custom types](https://www.postgresql.org/docs/current/sql-createtype.html) might be very useful to solve this exercise.