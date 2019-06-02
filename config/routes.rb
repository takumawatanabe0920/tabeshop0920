Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions',
    :omniauth_callbacks => 'users/omniauth_callbacks'
  }

  resources :users, only: [:show] do
    member do
      get :likes
    end
  end

  resources :favorites, only: [:create, :destroy]

  root to: 'shops#index'

  resources :shops, only: [:index,:new, :show]

  get 'likes/like', to: 'likes#like'

  devise_for :admins

  namespace :admins do
   root to: "dashboards#index"
   resources :shops, only: [:new, :create, :destroy]
  end

end
