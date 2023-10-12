# Doorkeeper Provider App

[![CI](https://github.com/doorkeeper-gem/doorkeeper-provider-app/actions/workflows/ci.yml/badge.svg)](https://github.com/doorkeeper-gem/doorkeeper-provider-app/actions/workflows/ci.yml)

This app is an example of an OAuth 2 provider using [Doorkeeper gem](https://github.com/doorkeeper-gem/doorkeeper), [Rails 7.x](http://rubyonrails.org/) and [Devise](https://github.com/plataformatec/devise).

## About Doorkeeper Gem

For more information [about the gem](https://github.com/doorkeeper-gem/doorkeeper), [documentation](https://github.com/doorkeeper-gem/doorkeeper#readme), [wiki](https://github.com/doorkeeper-gem/doorkeeper/wiki/_pages) and another resources, check out the project [on GitHub](https://github.com/doorkeeper-gem/doorkeeper)

## Installation

First clone the [repository from GitHub](https://github.com/doorkeeper-gem/doorkeeper-provider-app):

    git clone git@github.com:doorkeeper-gem/doorkeeper-provider-app.git

Install all dependencies with:

    bin/bundle install

For production : 

    RAILS_ENV=production bin/rails assets:precompile

## Configuration

The configuration is quite simple, all you need to do is run:

    bin/rails db:setup

This will generate all necessary tables, create fake data, create an user and a client application.

## Seed data

The generated user email is `user@example.com` and password is `doorkeeper`.

The application `id` and `secret` will show up on terminal when the script ends.

After that, you can just fire up the `bin/rails server` and you're ready to go.

## OAuth Endpoint

The endpoints is mounted under `/oauth` so our routes look like this:

    GET       /oauth/authorize
    POST      /oauth/authorize
    DELETE    /oauth/authorize
    POST      /oauth/token
    resources /oauth/applications

## Example API

This app provides a sample JSON API under `/api/v1`. The current API endpoints are:

    /api/v1/profiles.json
    /api/v1/me.json

In `routes.rb` you can check out how they're made:

``` ruby
namespace :api do
  namespace :v1 do
    resources :profiles
    get '/me' => "credentials#me"
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

This is required if you want to return data based on the current user, like in `credentials_controller.rb`

### Make Access Token Required

To make your API only available for OAuth users, you need to tell doorkeeper to require an access token in
your api controller, like this:

``` ruby
module Api::V1
  class ProfilesController < ApiController
    before_action :doorkeeper_authorize!

    def index
      render json: Profile.recent
    end
  end
end
```

However, see also the Doorkeeper wiki article about [using scopes](https://github.com/doorkeeper-gem/doorkeeper/wiki/Using-Scopes).

If you attempt to access any of the protected resources without an proper access token, you'll get an `401 Unauthorized` response.

## Client applications

You can manage all client applications in `/oauth/applications`.

