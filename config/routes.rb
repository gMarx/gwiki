Rails.application.routes.draw do

  resources :wikis
  resources :charges, only: [:new, :create]

  devise_for :users
  root 'welcome#index'
  get 'about' => 'welcome#about'
end
