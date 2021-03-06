Rails.application.routes.draw do
  get 'home' => 'home#index'
  get 'home/index'
  resources :poets
  get 'likes/create'
  devise_for :users
  resources :poems
  
  get '/search' => 'poets#search'
  post 'poems/:poem_id/likes' => 'likes#create'
  
  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
