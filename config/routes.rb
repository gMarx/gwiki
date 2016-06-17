Rails.application.routes.draw do

  resources :wikis do
    resources :collaborators, only: [:create, :destroy]
  end
  resources :charges, only: [:new, :create] do
    collection do
      post :downgrade #need collection method so there is no id
    end
  end

  devise_for :users
  root 'welcome#index'
  get 'about' => 'welcome#about'
end
