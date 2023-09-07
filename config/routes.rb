Rails.application.routes.draw do
  devise_for :models
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show]
  end

  root 'users#index', as: 'home'
end
