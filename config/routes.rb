# frozen_string_literal: true
Rails.application.routes.draw do
  root "events#index"

  session_con = \
    if Rails.env.development?
      "users/dummy_sessions"
    else
      "users/sessions"
    end

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
