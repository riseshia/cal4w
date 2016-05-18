# frozen_string_literal: true
Rails.application.routes.draw do
  root "events#index"

  devise_for :users, controllers: {
    omniauth_callbacks: "callbacks", sessions: "users/sessions"
  }

  namespace :api do
    resources :events
  end

  resources :events do
    post :join, on: :member
    post :unjoin, on: :member
    get :copy, on: :member
  end
end
