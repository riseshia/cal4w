Rails.application.routes.draw do
  get 'home/index'

  get 'callbacks/slack'

  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }

  root 'home#index'
end
