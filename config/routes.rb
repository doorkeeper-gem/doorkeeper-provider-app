DoorkeeperProvider::Application.routes.draw do
  mount Doorkeeper::Engine => '/oauth'

  devise_for :users

  namespace :api do
    namespace :v1 do
      resources :profiles
      get '/me' => "credentials#me"
      get '/fast' => 'fast#index'
    end
  end

  root :to => "home#index"
end
