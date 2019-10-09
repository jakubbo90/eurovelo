Rails.application.routes.draw do
  apipie
  resources :password_expirations
  resources :places do
    resources :pictures
    resources :videos
    resources :identities
    resources :addresses
    resources :trails
    collection do
      get :api_index
      post :import
    end
  end
  
  resources :trails do
    collection do
      post :import
    end
    resources :pictures
    resources :attachments
    resources :videos
  end
  
  resources :alerts do
    collection do
      post :import
    end
    resources :addresses
    resources :pictures
  end
  
  resources :users do
    member do
      get 'reset_password'
    end
  end
  resources :addresses
  resources :identities
  resources :attachments
  resources :videos
  resources :pictures
  resources :category_descriptions, only: [:index, :show, :update]
  resources :categories
  resources :regions, only: [:index, :show]
  resources :countries, only: [:index, :show]
  resources :trail_categories
  mount_devise_token_auth_for 'User', at: 'auth'
  
  get '/roles', to: 'users#roles', as: 'roles'
  get '/my_posts', to: 'users#my_posts', as: 'my_posts'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
