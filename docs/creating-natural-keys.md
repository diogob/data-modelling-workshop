# Creating natural keys

## Why?

[Natural keys](https://en.wikipedia.org/wiki/Natural_key) are identifiers we can use for relations that exist as an attribute of the domain and are used in the external world (outside of the database).

Modelling natural keys adds peace of mind for developers in the long run since they will prevent duplicate data (as long as the proper constraints are created in the database).

Auto-generated keys such as sequences and UUID will provide a mean to identify rows, but fail at preventing duplicate data.

A more subtle advantage of modelling natural keys is that they give insight into details of the data model such as:
* Distinguishing between [event data and entity data](https://keen.io/blog/event-data-vs-entity-data-how-to-store-user-properties-in-keen-io/).
* What are the rules for updating attributes that identify a row.
* Ensures that some thought is given to [functional dependencies](https://en.wikipedia.org/wiki/Functional_dependency).

## How?

A simple way to find natural keys is to think about which attributes satisfy its minimal requirements:
* The key must be unique within the relation.
* The key must be defined for every tuple of the relation (i.e. non-nullable).

Don't be afraid of composite keys, you can always use a [surrogate key](https://en.wikipedia.org/wiki/Surrogate_key) as a foreign key to simplify `JOINs`.

If you can find multiple natural keys, mark all of them, it might be a hint to decompose the relation.

## Exercise

Consider the following rules for the exercise:
 * Two users cannot have the same email.
 * Two repositories may have the same name only if they belong to distinct users.
 * Currently the system supports only 1 ssh key per user.
 * Ssh keys must be unique among all users.
 * There is no need to preserve any existing data.

Add unique indexes to ensure all rules above are preserved.
You could use unique constraints (that will imply the creation of unique indicies) but that is entirely optional.