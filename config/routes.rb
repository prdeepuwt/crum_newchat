Rails.application.routes.draw do
  resources :time_tables
  resources :tags
  resources :messages
  resources :attatchments
  resources :after_signup
  resources :bookmarks, only: [:index, :create]
  devise_for :users, :controllers => { registrations: 'registrations' }
  match '/users/:id', :to=> 'users#show' , :as=> :user, :via=> :get 
  match '/users', :to=> 'users#index', :as=> :users, :via=> :get 
  root to: "home#index"
  get '/about' => 'home#about'
  get 'dashboard' => 'home#dashboard'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
  resources :conversations do
    resources :messages do
      member do
        post 'add_remove_star'
        post 'add_remove_imp'
      end
    end
  end

end
