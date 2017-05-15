Rails.application.routes.draw do
  resources :lists, shallow: true, only: [:index, :create, :update] do
    resources :items, only: [:index, :show, :create, :update, :destroy] do
      post '/star', to: 'items#addstar'
      # delete '/star', to: 'items#delstar'
      resources :comments, only: [:index, :create, :destroy] do
        post '/star', to: 'comments#addstar'
        # delete '/star', to: 'comments#delstar'
      end
    end
  end

  mount_devise_token_auth_for 'User', at: 'auth', skip: [:sessions]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
