Rails.application.routes.draw do

  resources :wikis
  resources :charges, only: [:new, :create] do
    collection do
      post :downgrade #need collection method so there is no id
    end
  end
  resources :collaborators, only: [:create, :destroy]

  devise_for :users
  root 'welcome#index'
  get 'about' => 'welcome#about'
end
