Rails.application.routes.draw do
  root 'posts#index'
  devise_for :users
  resources :users
  get 'users/:id/likes' => "users#like"
  resources :posts do
    resources :comments, only: [:create]
    resources :likes, only: [:index, :create, :destroy]
  resources :relationships, only:[:create, :destroy]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
