Rails.application.routes.draw do
  resources :poets
  get 'likes/create'
  devise_for :users
  resources :poems
  
  post 'poems/:poem_id/likes' => 'likes#create'
  
  root 'poets#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
