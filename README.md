# Venmo

[![CircleCI](https://circleci.com/gh/rootstrap/rails_api_base.svg?style=svg)](https://circleci.com/gh/rootstrap/rails_api_base)
[![Code Climate](https://codeclimate.com/github/rootstrap/rails_api_base/badges/gpa.svg)](https://codeclimate.com/github/rootstrap/rails_api_base)
[![Test Coverage](https://api.codeclimate.com/v1/badges/63de7f82c79f5fe82f46/test_coverage)](https://codeclimate.com/github/rootstrap/rails_api_base/test_coverage)


`venmo-drill` is a basic payment service which allows friends to transfer money to each other. It also
has a social feature that shows your friends’ payment activities as feed. The project is based on Rails 6 and Ruby 2.7.

## Features

1. Send payment to a friend
2. List friends’ payment activities including yours in the feed
3. Check a user's account balance

## How to use

1. Clone this repo
1. Install PostgreSQL in case you don't have it
1. Run `./bootstrap.sh venmo_drill`
1. Run `rake db:seed`
1. `rspec` and make sure all tests pass
1. `rails s`
1. You can now try your REST services!

## Gems

- [Annotate](https://github.com/ctran/annotate_models) for doc the schema in the classes
- [Better Errors](https://github.com/charliesome/better_errors) for a better error page
- [Brakeman](https://github.com/presidentbeef/brakeman) for static analysis security
- [Bullet](https://github.com/flyerhzm/bullet) help to kill N+1
- [Byebug](https://github.com/deivid-rodriguez/byebug) for debugging
- [DelayedJob](https://github.com/collectiveidea/delayed_job) for background processing
- [Devise](https://github.com/plataformatec/devise) for basic auth
- [Devise Token Auth](https://github.com/lynndylanhurley/devise_token_auth) for api auth
- [Draper](https://github.com/drapergem/draper) for decorators
- [ExceptionHunter](https://github.com/rootstrap/exception_hunter) for exception tracking
- [Factory Bot](https://github.com/thoughtbot/factory_bot) for testing data
- [Faker](https://github.com/stympy/faker) for generating test data
- [Figaro](https://github.com/laserlemon/figaro) for handling environment variables
- [Jbuilder](https://github.com/rails/jbuilder) for json views
- [Letter Opener](https://github.com/ryanb/letter_opener) for previewing a mail in the browser
- [Oj](https://github.com/ohler55/oj) for optimized json
- [Kaminari](https://github.com/kaminari/kaminari) for pagination
- [Pry](https://github.com/pry/pry) for enhancing the ruby shell
- [Puma](https://github.com/puma/puma) for the server
- [Pundit](https://github.com/varvet/pundit) for authorization management
- [Rack CORS](https://github.com/cyu/rack-cors) for handling CORS
- [Rails Best Practices](https://github.com/flyerhzm/rails_best_practices) for rails linting
- [Reek](https://github.com/troessner/reek) for ruby linting
- [RSpec](https://github.com/rspec/rspec) for testing
- [Rspec API Doc Generator](https://github.com/zipmark/rspec_api_documentation) for API documentation
- [Rubocop](https://github.com/bbatsov/rubocop/) for ruby linting
- [Sendgrid](https://github.com/stephenb/sendgrid) for sending mails
- [Shoulda Matchers](https://github.com/thoughtbot/shoulda-matchers) adds other testing matchers
- [Simplecov](https://github.com/colszowka/simplecov) for code coverage
- [Webmock](https://github.com/bblimke/webmock) for stubbing http requests
- [YAAF](https://github.com/rootstrap/yaaf) for form objects

## Code quality

With `rake code_analysis` you can run the code analysis tool, you can omit rules with:

- [Rubocop](https://github.com/bbatsov/rubocop/blob/master/config/default.yml) Edit `.rubocop.yml`
- [Reek](https://github.com/troessner/reek#configuration-file) Edit `config.reek`
- [Rails Best Practices](https://github.com/flyerhzm/rails_best_practices#custom-configuration) Edit `config/rails_best_practices.yml`
- [Brakeman](https://github.com/presidentbeef/brakeman) Run `brakeman -I` to generate `config/brakeman.ignore`
- [Bullet](https://github.com/flyerhzm/bullet#whitelist) You can add exceptions to a bullet initializer or in the controller

## Configuring Code Climate
1. After adding the project to CC, go to `Repo Settings`
1. On the `Test Coverage` tab, copy the `Test Reporter ID`
1. Set the current value of `CC_TEST_REPORTER_ID` in the [circle-ci project env variables](https://circleci.com/docs/2.0/env-vars/#setting-an-environment-variable-in-a-project)

## Entity Relationship Diagram

<img src="https://github.com/nicofh/venmo-drill/blob/master/erd.png"/>

* Friendship concept was handled as a bidirectional association (e.g `user_a` and `user_b` friendship will be represented as only one Friendship table entry, whether `user_a` or `user_b` value is on `first_friend` or `second_friend` attribute will be exactly the same for the system.)

## Api Docs

<table>
    <thead>
        <tr>
            <th>API</th>
            <th>HTTP verb</th>
            <th>URI</th>
            <th>Request Parameters</th>
            <th>Response</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>Payment</td>
            <td>POST</td>
            <td><i>/user/{id}/payment</i></td>
            <td><i><b>friend_id</b></i> (integer), <i><b>amount</b></i> (float), <i><b>description</b></i> (string)</td>
            <td><b>Success</b>: return 200 code with empty body.<br>
                <b>Failure</b>: return HTTP error code with error description.</td>
        </tr>
        <tr>
            <td>Feed</td>
            <td>GET</td>
            <td><i>/user/{id}/feed</i></td>
            <td><i><b>page</b></i> (page_number for pagination, integer. If no page number in the params,       return first page by default. Each page contains at most 10 feed items.) </td>
            <td><b>Success</b>: return 200 code, body contains a list of feed items.<br>
                <b>Failure</b>: return HTTP error code with error description.</td>
        </tr>
        <tr>
            <td>Balance check</td>
            <td>GET</td>
            <td><i>/user/{id}/balance</i></td>
            <td>No parameters</td>
            <td><b>Success</b>: return 200 code, body contains balance.<br>
                <b>Failure</b>: return HTTP error code with error description.</td>
        </tr>
    </tbody>
</table>

## Services

This project has 3 main services.
- PaymentService handles the logic for creating a payment between two users. First it will validate that the receiver user is friend of the sender user, displaying the respective error message in case of failure. Then it will validate that the sender user's balance is equal or greater than the amount to transfer, if it's not it will proceed to call the service explained below. Finally if validations passed, a payment will be created.

- ExternalTransferService mocks an external payment source connection which is called whenever a user tries to transfer an amount greater than his account's balance. The service will act as a successful request to an external party and will add the required value for the user to make the transfer.

- FeedService will return all the payments that a given user should see on their feed. Such collection will be composed by his own payments plus his friends payments.

## Seed

After runnning `rake db:seed` a sample data will be loaded to the database. This data is composed by
4 friend users and 1 user with no friends (`user_5`). Friend users have payments where `user_{n}` has made a payment to `user_{n+1}`.

This example allows to test feed feature reach. If we hit GET Feed for `user_1`, we should see `user_1` and `user_2` activity only. On the other hand if we do that for `user_2` or `user_3`, we should see all activity.
Finally there should be no activity on `user_5`'s feed.

## Postman Collection

Download [venmo-drill Postman collection](https://github.com/nicofh/venmo-drill/blob/master/Venmo.postman_collection.json) and import to Postman.

[<img src="https://s3-us-west-1.amazonaws.com/rootstrap.com/img/rs.png" width="100"/>](http://www.rootstrap.com)
