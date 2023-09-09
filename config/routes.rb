Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions', confirmations: 'users/confirmations' }

  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create] do
      resources :comments, only: [:new, :create]
      resources :likes, only: [:create]
    end
  end

  root 'users#index', as: 'home'
end
