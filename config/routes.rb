Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'
  }

  devise_for :admins

  resources :users, only: [:show] do
    member do
      get :likes
    end
  end

  resources :favorites, only: [:create, :destroy]

  root to: 'shops#index'

  resources :shops, only: [:index, :show]

  get 'likes/like', to: 'likes#like'

  namespace :admins do
   root to: "dashboards#index"
   resources :shops, only: [:new, :create, :destroy]
  end

end
