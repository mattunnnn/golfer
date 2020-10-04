Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"
  resources :users
  resources :microposts do
    resource :favorites, only: [:create, :destroy]
  end
end
