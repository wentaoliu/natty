Rails.application.routes.draw do

  root 'home#index'

  devise_for :users

  resources :users
  resources :wikis do
    resources :versions
  end
  resources :instruments do
    resources :bookings
  end
  resources :forums do
    resources :topics, only: [:index, :new, :create]
  end
  resources :topics, only: [:show, :edit, :update, :destroy] do
    resources :comments, only: [:create, :destroy]
  end
  resources :resources
  resources :schedules
  resources :inventories
  resources :messages, only: [:index, :create, :destroy] do
    put 'like', on: :member
  end
  resources :profiles
  namespace :settings do
    get '/' => 'emails#edit'
    resource :email, only: [:edit, :update]
    resource :avatar, only: [:edit, :update]
    resource :password, only: [:edit, :update]
    resource :locale, only: [:edit, :update]
  end
  resources :pictures, only: [:create]

  # API
  mount Dispatch => '/api'
end
