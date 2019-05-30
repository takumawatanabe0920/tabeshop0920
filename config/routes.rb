Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'
  }

  resources :users, only: [:show] do
    member do
      get :likes
    end
  end

  resources :favorites, only: [:create, :destroy]

  root to: 'shops#index'

  namespace :admin do
    root "shops#index"
  end

  resources :shops

  get 'likes/like', to: 'likes#like'

end
