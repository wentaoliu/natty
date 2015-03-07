Rails.application.routes.draw do

  root 'home#index'

  get 'signin' => 'sessions#new', as: :signin
  delete 'signout' => 'sessions#destroy', as: :signout
  resources :sessions

  resources :users
  resources :wikis do
    member do
      get :versions
    end
  end
  resources :equipments
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
