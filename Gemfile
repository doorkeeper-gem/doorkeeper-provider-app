# frozen_string_literal: true

source "http://rubygems.org"

ruby "3.1.2"

gem "rails", "~> 7.1"
gem "doorkeeper", "~> 5.6.6"
gem "devise", "~> 4.9"
gem "sprockets-rails", require: "sprockets/railtie"

gem "faker"
gem "jquery-rails"

gem "coderay"
gem "redcarpet"

gem "uglifier"
gem "rollbar"

gem "puma"
gem "rack-timeout"

gem "mysql2"
gem "dotenv-rails", require: "dotenv/rails-now", groups: [:development, :test]

group :development do
  gem "listen"
  gem "rubocop-performance"
  gem "rubocop-rails_config"
end

group :test do
  gem "rspec-rails"
  gem "factory_bot_rails"
  gem "database_cleaner"
end

group :development, :test do
  gem "pry-rails"
end
