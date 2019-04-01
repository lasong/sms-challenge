## Technologies

- Ruby on Rails 5 (API only)
- React
- Nginx proxy
- Docker compose
- Postgresql

## Prerequisites

- Docker
- Docker compose

## Setup

Before you run the application for the first time, you must create the database, run migrations and seed the database:

```
docker-compose run backend rake db:create db:migrate db:seed
```

## Running the application

Start the app by running:

```
docker-compose up
```

Then go to your browser and navigate to `http://localhost:8080`.


## Running backend test

If running for the first time, setup the test database:

```
docker-compose run backend rake db:test:prepare
```

Then run the tests:

```
docker-compose run backend rspec spec
```
