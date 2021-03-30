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
```

## Getting started

1. [Removing `NULLs`](./docs/removing-nulls.md)
2. Creating natural keys
3. Avoid storing impossible states
4. Modelling events for input and deriving entities from views