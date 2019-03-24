# frozen_string_literal: true

Rails.application.routes.draw do
  use_doorkeeper

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  # Project administration via UI
  resources :projects

  namespace :api do
    namespace :v1 do
      resources :projects
      get '/me' => 'credentials#me'
    end
  end

  root to: 'home#index'
end
