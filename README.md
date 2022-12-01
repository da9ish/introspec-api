# Helpful Alias
```shell
  alias be='bundle exec'
  alias br='bundle exec heroku local:run'
  alias bi='bundle check --path=.bundle || bundle install --path=.bundle --binstubs .bundle/bin --jobs=4 --retry=3'
  alias bu='bundle update --path .bundle --verbose --binstubs .bundle/bin; rbenv rehash'
  alias brucop='bundle exec rubocop -a -D $(git diff --cached --name-only --diff-filter=d HEAD | egrep ".(rb|rake)$" | egrep -v "db\/schema.rb" | egrep -v "lib\/pb") Gemfile'
  alias brucop-full='bundle exec rubocop -a'
  alias brails='brails-local'
  alias brails-local='bundle exec heroku local:run -e .env-local rails'
  alias brails-development='bundle exec heroku local:run -e .env-development rails'
  alias brails-live='bundle exec heroku local:run -e .env-live rails'
  alias brails-canary='bundle exec heroku local:run -e .env-canary rails'
  alias boreman='reset && boreman-local'
  alias boreman-local='bundle exec heroku local -f Procfile.local -e .env-local'
  alias boreman-development='bundle exec heroku local -f Procfile.development -e .env-development'
  alias boreman-live='bundle exec heroku local -f Procfile -e .env-live'
  alias boreman-canary='bundle exec heroku local -f Procfile -e .env-canary'
```


# Getting Started

- Install Ruby v3.1.2
- Install deps `bundle install` or `bi`
- Create a new postgres user with following creds:
  - username: introspec_api
  - password: introspec_api
- Database setup `bundle exec heroku local:run -e .env-local rails db:drop db:create db:migrate db:seed` or `brails ...`
- Start server `bundle exec heroku local -f Procfile.local -e .env-local` or `boreman`



