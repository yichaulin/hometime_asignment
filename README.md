# Reservation Callback API Server
To accept reservation requests from clients (Airbnb, Booking.com ... ect).
It would parse the different format of request body from different clients and store to database.

## Prerequisite:
1. Install Ruby (v3.0.2)
    ```shell
    brew install ruby
    ```
2. Install Rails (v6.1.4.1)
    ```shell
    gem install rails
    ```
3. Install needed packages
    ```shell
    bundle install
    ```
4. Migrate db schema
    ```shell
    # dev
    rails db:migrate

    # production
    rails db:migrate RAILS_ENV=production
    ```

## Run the server
```shell
# dev (localhost)
rails server

# production (as a Daemon)
rails server -e production -d -p {port || 3000}
```

## Run tests
```shell
bundle exec rspec
```