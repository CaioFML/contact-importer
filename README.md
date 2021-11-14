# README

This project is an importer of contacts by uploading csv files!

**This project is deployed on heroku and can be accessed from the url:** https://contact-importer-koombea-test.herokuapp.com/

*The credentials for test is the same of the step 9.*

## Setup

### Prerequisites

The setup steps expect following tools installed on the system.

- Git
- Ruby 3.0.0
- Rails 6.1.4.1
- PostgreSQL

### Steps to run project

1. Clone this the repository:

```
    $ git clone git@github.com:CaioFML/contact-importer.git
```

2. Go to the folder and bundle install:

```
    $ cd contact-importer
    $ bundle install
```

2. Run yarn:

```
    $ yarn
```

4. Create, setup and generate seeds in the database:

```
    $ rails db:setup
    $ rails db:migrate
```

4. Running tests:

```
    $ rails db:test:prepare
    $ bundle exec rspec
```

*The coverage of tests can be verified opening: `./coverage/index.html`*

5. Running rubocop:

```
    $ bundle exec rubocop
```

7. Run server, webpacker-dev-server (to compile the assets) and sidekiq (use different tabs of console for each command):

```
    $ rails s
    $ bin/webpack-dev-server
    $ sidekiq
```

9. A user with email: `test@test.com` and password: `123456` is created in the database.

10. Use the csv files stored on `spec/fixture/files/**` as tests for upload on project.
