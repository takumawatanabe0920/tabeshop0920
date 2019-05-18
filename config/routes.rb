Rails.application.routes.draw do
  root to: 'shops#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'signup', to: 'users#new'
  resources :users do
    member do
    get :likes
   end
  end

  resources :shops
  resources :favorites, only: [:create, :destroy]
end
