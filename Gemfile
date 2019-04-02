# frozen_string_literal: true

source "http://rubygems.org"

ruby "2.6.2"

gem "rails", "~> 5.2"
gem "doorkeeper", "~> 5.0"
gem "devise", "~> 4.6"
gem "bootsnap", require: false

gem "faker"
gem "jquery-rails"

gem "coderay"
gem "redcarpet"

gem "pg", "~> 1.1",      group: :production
gem "sqlite3", group: [:development, :test], platform: [:ruby, :mswin, :mingw, :x64_mingw]

gem "puma"
gem "rack-timeout"

gem "sass-rails"
gem "coffee-rails"
gem "uglifier"

group :development do
  gem "listen"
  gem "rubocop-rails_config"
end

group :test do
  gem "rspec-rails"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw]
