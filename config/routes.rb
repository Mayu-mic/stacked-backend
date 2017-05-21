Rails.application.routes.draw do
  resources :lists, shallow: true, only: [:index, :create, :update] do
    resources :stacks, only: [:index, :show, :create, :update, :destroy] do
      post '/like', to: 'stacks#addlike'
      delete '/like', to: 'stacks#dellike'
      patch '/status', to: 'stacks#change_status'
      resources :comments, only: [:index, :create, :destroy] do
        post '/like', to: 'comments#addlike'
        delete '/like', to: 'comments#dellike'
      end
    end
  end

  mount_devise_token_auth_for 'User', at: 'auth'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
