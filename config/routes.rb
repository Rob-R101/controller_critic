Rails.application.routes.draw do
  get 'home/index'
  devise_for :users
  root "home#index"

  resources :users, only: [:show, :update]

  resources :games, only: [:index, :show] do
    resources :reviews, only: [:index]
  end
end
