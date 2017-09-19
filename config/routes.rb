Rails.application.routes.draw do

  root 'home#index'

  devise_for :users

  use_doorkeeper

  resources :users
  resources :groups
  resources :wikis do
    member do
      get :versions
    end
  end
  resources :instruments
  shallow do
    resources :forums do
      resources :topics do
        resources :comments, only: [:create, :destroy]
      end
    end
  end
  resources :resources
  resources :news
  resources :orders
  resources :achievements
  resources :schedules
  resources :meetings
  resources :inventories
  resources :messages, only: [:index, :create, :destroy] do
    put 'like', on: :member
  end
  resource :profile, only: [:edit, :update] do
    put 'photo', on: :member
  end
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
