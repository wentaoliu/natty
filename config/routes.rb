Rails.application.routes.draw do

  root 'home#index'

  get 'signin' => 'sessions#new', as: :signin
  delete 'signout' => 'sessions#destroy', as: :signout
  resources :sessions, only: [:new, :create, :destroy]

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
  resource :profile, :setting

end
