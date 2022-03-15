# README

![building?](https://github.com/sherwin-kwan/dm-project/actions/workflows/test.yml/badge.svg)

This is a blog webapp for practicing good TDD and CI habits.

Runs on:
* Ruby 3.1
* Rails 7.0
* PostgreSQL 

To run it locally, clone the repo and then make sure all dependencies are installed: (this assumes you already have the right Ruby version)
```
gem install bundler
bundle install
rails db:setup db:migrate
```

Then, `rails s` starts the server, or `bundle exec rspec` runs the test suite.

If database creation fails for whatever reason, you may need to enter the `psql` console and manually create the needed databases:
```
psql
> CREATE DATABASE dm_project_test;
> CREATE DATABASE dm_project_development;
> exit
```