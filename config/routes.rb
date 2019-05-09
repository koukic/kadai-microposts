Rails.application.routes.draw do
  root to: 'toppages#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'signup', to: 'users#new'
   resources :users do
    member do
        get :followings
        get :followers
        get :likes
        get :likers
    end
  end
    resources :favorites, only: [:create, :destroy]
    resources :microposts, only: [:create, :destroy]
    resources :relationships, only: [:create, :destroy]
end