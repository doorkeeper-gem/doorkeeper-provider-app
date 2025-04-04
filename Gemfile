# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.0"

gem "rails", "~> 7.2"
gem "doorkeeper", "~> 5.8.2"
gem "devise", "~> 4.9"
gem "sprockets-rails", require: "sprockets/railtie"

gem "faker"
gem "jquery-rails"

gem "coderay"
gem "redcarpet"

gem "uglifier"
gem "pg", "~> 1.5", group: :production
gem "rollbar"

gem "puma"
gem "rack-timeout"

group :development do
  gem "listen"
  gem "rubocop-performance"
  gem "rubocop-rails_config"
end

group :test do
  gem "rspec-rails"
  gem "factory_bot_rails"
  gem 'database_cleaner-active_record'
end

group :development, :test do
  gem "sqlite3"
  gem "pry-rails"
end
