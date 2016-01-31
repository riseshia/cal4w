Rails.application.routes.draw do
  root 'events#index'

  get 'callbacks/slack'

  devise_for :users, controllers: { omniauth_callbacks: 'callbacks', registrations: 'users/registrations' }

  resources :events do
    post :join, on: :member
    post :unjoin, on: :member
  end
end
