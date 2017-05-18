Rails.application.routes.draw do
  resources :lists, shallow: true, only: [:index, :create, :update] do
    resources :stacks, only: [:index, :show, :create, :update, :destroy] do
      post '/star', to: 'stacks#addstar'
      # delete '/star', to: 'stacks#delstar'
      patch '/status', to: 'stacks#change_status'
      resources :comments, only: [:index, :create, :destroy] do
        post '/star', to: 'comments#addstar'
        # delete '/star', to: 'comments#delstar'
      end
    end
  end

  mount_devise_token_auth_for 'User', at: 'auth'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
