# Removing Nulls from your model

## Why?

A lot has been [written](https://en.wikipedia.org/wiki/Null_pointer) and [said](https://www.infoq.com/presentations/Null-References-The-Billion-Dollar-Mistake-Tony-Hoare/) about null pointers in programming language.
It requires special attention from the developers and some boiler plate to handle it properly.

In SQL database systems the `NULL` is a state where the value is unknown. This behaves slightly better than in the case of null pointers, but we still have to be careful when using it. Firtly because a lot of programming languages will map the database `NULL` to some sort of null pointer. Secondly because most database opteraions over `NULLs` are counter-intuitive since their result is always NULL. The exceptions are functions and operators designed specially for `NULL` handling (e.g. `IS NULL`, `coalesce`).

Try on `psql`:
```
psql data_modelling_workshop_development
```

First compare the constant `0` to itself.
```
data_modelling_workshop_development=# select 0 = 0;
 ?column?
----------
 t
(1 row)
```
The return is `t` for true since the equality is true.

Now let's try a case where the equality is false. Try comparing the constants `0` and `1`.
```
data_modelling_workshop_development=# select 0 = 1;
```

The return should be `f` for false.

Lastly, let's the constants `0` and `NULL`.
```
data_modelling_workshop_development=# select 0 = NULL;
```

What is the value for the expression above?

Also, could you guess what is the value for the expression `select 1 not in (0, NULL, 2);` ?

Now that we know that `NULL` states can be tricky, we might want to remove some nullable columns from our model.
This shows mercy towards future developers querying the database, but it makes a bit harder to input data.
Usually there is a trade-off in models where the harder it is to write data, the easier it is to read it later.

Think of your model as a sieve that will filter out bad states, the coarser the sieve is, the dirtier the data will get to its consumers.

## How?

You should use the [Not-Null constraint](https://www.postgresql.org/docs/current/ddl-constraints.html#id-1.5.4.6.6) on tables as much as possible to avoid unnecessary nulls. For every field in every relation answer the question: "Does it make sense to store this data leaving out this field?"

Sometimes a `NULL` might indicate a deeper issue with model. If the existence of a `NULL` is correlated with another field in the same relation, that indicates we could extract a relation containing the nullable fields.

## Exercise

Check the columns in the user relation on psql:

```
data_modelling_workshop_development=# \d users
```

It should look like:

```
                                      Table "public.users"
       Column       |              Type              | Collation | Nullable |      Default
--------------------+--------------------------------+-----------+----------+-------------------
 id                 | uuid                           |           | not null | gen_random_uuid()
 email              | text                           |           |          |
 password           | text                           |           |          |
 ssh_key            | text                           |           |          |
 ssh_key_name       | text                           |           |          |
 ssh_key_created_at | text                           |           |          |
 created_at         | timestamp(6) without time zone |           | not null |
 updated_at         | timestamp(6) without time zone |           | not null |
Indexes:
    "users_pkey" PRIMARY KEY, btree (id)
Referenced by:
    TABLE "repositories" CONSTRAINT "fk_rails_5c7f0a15dd" FOREIGN KEY (user_id) REFERENCES users(id)
```

Consider the following rules for the exercise:
 * Every user must have email and password.
 * Some users might not have ssh keys.
 * Currently the system supports only 1 ssh key per user.
 * There is no need to preserve any existing data.

Create migrations to eliminate all nullable columns from the model `User`.
