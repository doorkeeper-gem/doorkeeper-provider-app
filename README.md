# Doorkeeper Provider App

[![CI](https://github.com/doorkeeper-gem/doorkeeper-provider-app/actions/workflows/ci.yml/badge.svg)](https://github.com/doorkeeper-gem/doorkeeper-provider-app/actions/workflows/ci.yml)

This app is an example of an OAuth 2 provider using [Doorkeeper gem](https://github.com/doorkeeper-gem/doorkeeper), [Rails 8.1](https://rubyonrails.org/) and [Devise](https://github.com/heartcombo/devise).

## Live demo

A live demo of this app is available at:

https://doorkeeper-provider-app-q2edl.eu-east-1.migetapp.com

You can sign in with the seed user (`user@example.com` / `doorkeeper`) to explore the OAuth flow, manage client applications and try the example API.

## About Doorkeeper Gem

For more information [about the gem](https://github.com/doorkeeper-gem/doorkeeper), [documentation](https://github.com/doorkeeper-gem/doorkeeper#readme), [wiki](https://github.com/doorkeeper-gem/doorkeeper/wiki) and other resources, check out the project [on GitHub](https://github.com/doorkeeper-gem/doorkeeper).

## Requirements

- Ruby 3.3 (see `.ruby-version`)
- Rails 8.1
- Doorkeeper 5.9
- Devise 5.0
- SQLite (development and test) or PostgreSQL (production)

## Installation

First clone the [repository from GitHub](https://github.com/doorkeeper-gem/doorkeeper-provider-app):

    git clone git@github.com:doorkeeper-gem/doorkeeper-provider-app.git

Install all dependencies with:

    bin/bundle install

After that you're almost ready to go.

## Configuration

The configuration is quite simple, all you need to do is run:

    bin/rails db:setup

This will generate all necessary tables, create a user and a client application.

## Seed data

The generated user email is `user@example.com` and password is `doorkeeper`.

The application `uid` and `secret` will show up on terminal when the script ends.

After that, you can just fire up the `bin/rails server` and you're ready to go.

## Running the tests

    bin/rails db:setup
    bundle exec rspec

## OAuth Endpoint

The endpoints are mounted under `/oauth` so our routes look like this:

    GET       /oauth/authorize
    POST      /oauth/authorize
    DELETE    /oauth/authorize
    POST      /oauth/token
    POST      /oauth/revoke
    POST      /oauth/introspect
    GET       /oauth/token/info
    resources /oauth/applications
    resources /oauth/authorized_applications

## Example API

This app provides a sample JSON API under `/api/v1`. The current API endpoints are:

    /api/v1/projects
    /api/v1/me

In `routes.rb` you can check out how they're made:

``` ruby
namespace :api do
  namespace :v1 do
    resources :projects
    get '/me' => 'credentials#me'
  end
end
```

We namespace the API controllers to avoid name clashing and collisions between your existing application and the API.
This way, you can make changes to your application without messing up with the API's behavior.

You can find all controllers under `/app/controllers/api/v1` folder.

The `api_controller.rb` works as a parent class to the other controllers. It only defines a method that returns
the current resource owner, based on the access token:

``` ruby
def current_resource_owner
  User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
end
```

This is required if you want to return data based on the current user, like in `credentials_controller.rb`.

### Make Access Token Required

To make your API only available for OAuth users, you need to tell doorkeeper to require an access token in
your api controller, like this:

``` ruby
module Api::V1
  class CredentialsController < ApiController
    before_action :doorkeeper_authorize!

    def me
      render json: current_resource_owner
    end
  end
end
```

You can also require specific scopes. This app defines `read` as the default scope and `write` as an optional
scope, and `projects_controller.rb` uses them like this:

``` ruby
module Api::V1
  class ProjectsController < ApiController
    before_action -> { doorkeeper_authorize! :read }, only: %i[index show]
    before_action -> { doorkeeper_authorize! :write }, only: %i[create update destroy]

    def index
      render json: current_resource_owner.projects
    end
  end
end
```

See also the Doorkeeper wiki article about [using scopes](https://github.com/doorkeeper-gem/doorkeeper/wiki/Using-Scopes).

If you attempt to access any of the protected resources without a proper access token, you'll get a `401 Unauthorized` response.

## Client applications

You can manage all client applications in `/oauth/applications`.

A sample client for this provider is available at [doorkeeper-sinatra-client](https://github.com/doorkeeper-gem/doorkeeper-sinatra-client).
