require 'sidekiq/web'

Rails.application.routes.draw do

  get 'favourites/update'
  get 'users/favourite', to: 'users#favourite'
  post 'filtered/ideas', to:'ideas#filtered'
  resources :ideas
  post 'ideas/create', to: 'ideas#create'
    authenticate :user, lambda { |u| u.admin? } do
      mount Sidekiq::Web => '/sidekiq'
    end
  
 
  
  devise_for :users
  resources :users, only: [:index, :show]
  resources :conversations
  root to: 'ideas#index'
  resources :messages
  resources :room_messages
  resources :rooms
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
