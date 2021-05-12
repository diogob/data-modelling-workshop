# Modelling events for input and deriving entities from views

## Why?

Understanding the difference between modelling events and entities can make your data models much simpler, easier to audit and sometime can even bring performance benefits.

Entities are abstractions over events so technically you could model the entire database as either one of them. Entities will carry less data but the operations are more complex since they change over time.

Events are immutable so once they are usually modelled in append only relations. Listen to your model, if you are considering a natural key that contains a timestamp you are probably modelling an event, since entities are abstractions over time they have keys that are time-independent by definition.

Some example cases where events are a good choice:
* Interactions with other systems that are ireversible and might need troubleshooting. Such as API authentications, use of external APIs for payments.
* Cases where there is the need to revert an entity to a previous point in time. Such as storing some state changes for a given entity.
* Auditing the data history and manage state changes. Such as authorizations given by users in the system.

Once we model events in the database is often useful to aggregate the event data and calculate an entity just like in [event sourcing](https://martinfowler.com/eaaDev/EventSourcing.html). One simple way to calculate aggregates in a relational database is to create a view over the events. The view will act as a [fold (AKA reducer)](https://en.wikipedia.org/wiki/Fold_%28higher-order_function%29).

## How?

Define a time based natural key (with the record creation timestamp). It's useful, even in events, to add other attributes to the natural key. This might avoid bugs where the application worngly generates several records with the same timestamp. Remember that if one uses `now()` or `current_timestamp` in the database that will always be the timestamp of the start of the transaction, making all operations inside the same trabsaction atomic in time.

## Exercise

As an exercise we will extend our model to include information payment cancellations.
Take the following rules into account:

* Once a payment has been created it cannot be altered in any way, but it can be cancelled.
* A subscription state depends on both it's payments and the payment cancellations.
* Subscriptions are active if and only if there is a payment without cancellations in the last 30 days.

Create a relation to store payments cancellations.
Implement a view over subscriptions, payments and cancellations called `subscription_states`. This view will have a field called `active`, this is a boolean indicating whether the subscription is active or not.
Keep in mind that the gem [scenic](https://github.com/scenic-views/scenic) will be very useful to solve this exercise.