require 'sidekiq/web'

Rails.application.routes.draw do
  resources :ideas
    authenticate :user, lambda { |u| u.admin? } do
      mount Sidekiq::Web => '/sidekiq'
    end

  
  devise_for :users
  resources :users, only: [:index, :show]
  resources :conversations
  root to: 'home#index'
  resources :messages
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
