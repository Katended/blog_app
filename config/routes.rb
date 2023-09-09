Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions', confirmations: 'users/confirmations' }

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create, :destroy] do
      resources :comments, only: [:new, :create]
      resources :likes, only: [:create]
    end
  end

  root 'users#index', as: 'home'
end
