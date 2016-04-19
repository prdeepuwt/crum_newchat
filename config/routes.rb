Rails.application.routes.draw do
  resources :tags
  resources :messages
  resources :attatchments
  resources :after_signup
  resources :bookmarks, only: [:index, :create, :destroy]
  devise_for :users, :controllers => { registrations: 'registrations' }
  root to: "home#index"
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
