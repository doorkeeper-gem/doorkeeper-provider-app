DoorkeeperProvider::Application.routes.draw do
  mount Doorkeeper::Engine => '/oauth'

  devise_for :users

  namespace :api do
    namespace :v1 do
      resources :profiles
    end
  end

  root :to => "home#index"
end
