DoorkeeperProvider::Application.routes.draw do
  mount Doorkeeper::Engine => '/oauth'

  devise_for :users

  root :to => "home#index"
end
