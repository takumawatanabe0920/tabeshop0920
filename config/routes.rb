Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  resources :users, only: [:show] do
    member do
      get :likes
    end
  end

  resources :favorites, only: [:create, :destroy]

  root to: 'shops#index'

  resources :shops, only: [:index,:new, :show]

  resources :shops do
    resources :reviews, only: [:new, :create, :show]
  end

  get 'likes/like', to: 'likes#like'

  devise_for :admins

  namespace :admins do
   root to: "dashboards#index"
   resources :shops, only: [:new, :create, :destroy]
  end

  namespace :places do
    get 'list'

  end

  resources :place, :only => [ :index, :show, :create, :destroy ]

  get "rankings/review", to: "rankings#review"
end
