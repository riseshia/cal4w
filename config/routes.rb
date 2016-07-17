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
    resources :events
  end

  resources :events do
    post :join, on: :member
    post :unjoin, on: :member
    get :copy, on: :member
  end
end
