Rails.application.routes.draw do

  root 'home#index'

  get 'signin' => 'sessions#new', as: :signin
  delete 'signout' => 'sessions#destroy', as: :signout
  resources :sessions, only: [:new, :create, :destroy]

  resource :password, only: [:new, :create, :edit, :update]
  resources :users
  resources :wikis do
    member do
      get :versions
    end
  end
  resources :instruments
  resources :topics, except: [:edit, :update] do
    resources :comments, only: [:create, :destroy]
  end
  resources :resources
  resources :news
  resources :bulletins
  resources :achievements
  resources :schedules
  resources :meetings
  resources :messages
  resource :profile, only: [:edit, :update]
  namespace :settings do
    get '/' => 'usernames#edit'
    resource :username, only: [:edit, :update]
    resource :email, only: [:edit, :update]
    resource :avatar, only: [:edit, :update]
    resource :password, only: [:edit, :update]
    resource :locale, only: [:edit, :update]
  end
  resources :pictures, only: [:create]
end
