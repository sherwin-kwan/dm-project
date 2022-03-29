# README

![building?](https://github.com/sherwin-kwan/dm-project/actions/workflows/test.yml/badge.svg)
[![Maintainability from Code Climate](https://api.codeclimate.com/v1/badges/9988f5a29107c3da442c/maintainability)](https://codeclimate.com/github/sherwin-kwan/dm-project/maintainability)
[![codecov](https://codecov.io/gh/sherwin-kwan/dm-project/branch/master/graph/badge.svg?token=3FIKBG7MY8)](https://codecov.io/gh/sherwin-kwan/dm-project)

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