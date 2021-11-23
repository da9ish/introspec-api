# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.2"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem "rails", "~> 6.1.4", ">= 6.1.4.1"
# Use sqlite3 as the database for Active Record
gem "sqlite3", "~> 1.4"
# Use Puma as the app server
gem "devise", "~> 4.8"
gem "devise-jwt", "~> 0.8.0"
gem "puma", "~> 5.0"

gem "awesome_print", "~> 1.9", ">= 1.9.2"
gem "jbuilder", "~> 2.7"
gem "rack-cors", "~> 1.1", ">= 1.1.1"
gem "redis", "~> 4.0"
gem "rubocop", "~> 1.23", require: false
gem "rubocop-rails", "~> 2.12", ">= 2.12.4", require: false

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", ">= 1.4.4", require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

gem "aws-sdk", "~> 3.1"

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem "byebug", platforms: %i[mri mingw x64_mingw]
  gem "pry", "~> 0.13.1"
  gem "pry-rails", "~> 0.3.9"
end

group :development do
  gem "listen", "~> 3.3"
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "spring"

  gem "guard", "~> 2.16"
  gem "guard-minitest", "~> 2.4"
  gem "minitest-focus", "~> 1.2"

  gem "solargraph", "~> 0.44.0", require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
