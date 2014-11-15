Houzio::Application.routes.draw do  
  resources :activities

  devise_for :users, :path_names => {:sign_in => 'login'}, :controllers => { :registrations => "registrations" }
  devise_scope :user do
    get "login", :to => "devise/sessions#new"
  end

  root to: "home#index"
  get 'welcome/plans' => 'home#welcome_plans'
  get 'upgrade' => 'home#upgrade'
  get 'dashboard' => 'dashboard#index'
  post 'send_contact' => 'home#send_contact' 

  resources :users
  resources :rates
  resources :letters

  resources :reservations do
    member do
      match :edit_notes, :via => [:put, :get]
    end 
  end

  resources :properties do
    resources :rates, controller: 'properties/rates'
    resources :pictures, controller: 'properties/pictures'
    member do     
      get   :booking_detail
      get   :rental_history
      post  :update_rates
    end
    collection do
      get :tags
    end
  end
end
