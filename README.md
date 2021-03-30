# Data Modelling Workshop

This workshop will work with a model that should be familiar to most developers. Software repository management inspired by Github funcionality. The goal is not to model in detail the real funcionality but to narrow down some examples that will illustrate useful tecniques.

## Setup

For the workshop you will need to have installed:
* [Rails](https://rubyonrails.org/)
* [PostgreSQL](https://www.postgresql.org/)
* [git](https://git-scm.com/)

Then just clone the repo and install the bundle:

```bash
$ git clone https://github.com/diogob/data-modelling-workshop.git
$ cd data-modelling-workshop && bundle install
$ bundle exec rake db:setup
```

## About this repository

This Rails project will be used just as a shell to execute migrations.
Keep 2 terminals always open, one in a shell at the project root to execute `rake` commands and a second one in a `psql` session so you can inspect the database.

In the `psql` shell, before starting the tutorial, try the commands `\?` and `\h`, they will be very handy.

Get acquainted with the relations that were created and the migrations before proceding.

First tip of the tutorial: UUID keys are awesome.

## Getting started

1. [Removing `NULLs` from your model](./docs/removing-nulls.md)
2. [Creating natural keys](./docs/creating-natural-keys.md)
3. [Avoid storing impossible states](./docs/avoid-storing-impossible-states.md)
4. [Modelling events for input and deriving entities from views](./docs/modeling-events-for-input-and-deriving-entities-from-views.md)