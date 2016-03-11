Rails.application.routes.draw do
  root 'events#index'

  devise_for :users, controllers: { omniauth_callbacks: 'callbacks', registrations: 'users/registrations', sessions: 'users/sessions' }
  devise_scope :user do
    get 'callbacks/slack', to: 'callbacks#slack'
  end

  resources :events do
    post :join, on: :member
    post :unjoin, on: :member
    get :copy, on: :member
  end
end
