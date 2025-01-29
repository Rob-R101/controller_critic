Rails.application.routes.draw do
  get 'home/index'
  devise_for :users
  root "home#index"

  resources :users, only: [:show, :update]

  resources :games, only: [:index, :show] do
    resources :my_games, only: [:create]
    resources :reviews, only: [:index, :create]
  end

  resources :my_games, only: [:index, :destroy, :update]

end
