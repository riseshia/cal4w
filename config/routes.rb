# frozen_string_literal: true
Rails.application.routes.draw do
  root "events#index"

  session_con =
    Rails.env.production? ? "users/sessions" : "users/sessions"

  devise_for :users, controllers: {
    omniauth_callbacks: "callbacks", sessions: session_con
  }

  namespace :api do
    resources :events, only: [:index, :show]
  end

  resources :events do
    post :join, on: :member
    post :unjoin, on: :member
  end
end
