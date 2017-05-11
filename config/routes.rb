Rails.application.routes.draw do
  resources :comment_stars
  resources :comments
  resources :lists, shallow: true, only: [:index, :create, :update] do
    resources :items do
      post '/star', to: 'items#addstar'
      delete '/star', to: 'items#delstar'
    end
  end

  mount_devise_token_auth_for 'User', at: 'auth'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
