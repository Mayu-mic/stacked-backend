Rails.application.routes.draw do
  resources :comment_stars
  resources :comments
  resources :item_stars
  resources :items
  resources :lists, only: [:index]
  mount_devise_token_auth_for 'User', at: 'auth'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
