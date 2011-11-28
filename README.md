# Doorkeeper Provider App

This app is an example of an OAuth 2 provider using [doorkeeper](https://github.com/applicake/doorkeeper), Rails 3.1 and [Devise](https://github.com/plataformatec/devise). Check out the app hosted on [heroku](http://doorkeeper-provider.herokuapp.com/) for a live demo and documentation details.

## Installation

First clone the repository from GitHub:

    git clone git://github.com/applicake/doorkeeper-provider-app.git

Install all dependencies with:

    bundle install

After that you're almost ready to go.

## Configuration

The configuration is quite simple, all you need to do is run:

    bundle exec rake db:setup

This will generate all necessary tables, create fake data, create an user and a client application.

The user email is `user@example.com` and password is `doorkeeper`.

The application `id` and `secret` will show up on terminal when the script ends.

After that, you can just fire up the `rails server`.

## API

This app also provides a sample JSON API under `/api/v1`. This API is only available via OAuth so if you want to create a client application, check out [app's documentation](http://doorkeeper-provider.herokuapp.com/#client) or follow [this Sinatra example](http://doorkeeper-sinatra.herokuapp.com/) for more details.

The current API endpoints are:

    /api/v1/profiles.json
    /api/v1/me.json

In `routes.rb` you can check out how they're made:

    namespace :api do
      namespace :v1 do
        resources :profiles
        get '/me' => "credentials#me"
      end
    end

We namespace the API controllers to avoid name clashing and collisions between your existing application and the API. This way you can make your API stable while changing the behavior of your app.

You can find all controllers under `/app/api/v1` folder.

The `api_controller.rb` works as a parent class to the other controllers. It only defines a method that returns the current resource owner, based on the access token:

    def current_resource_owner
      User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
    end

### Require access token

To make your API only available for OAuth users, you need to tell doorkeeper to require an access token in your controller, like this:

    module Api::V1
      class ProfilesController < ApiController
        doorkeeper_for :all # require access token in all actions
        respond_to     :json

        def index
          respond_with Profile.all
        end
      end
    end

If you access this resource without an access token, you'll get an `401 Unauthorized` response status.