Secondhouz::Application.routes.draw do  
  resources :activities

  devise_for :users, :path_names => {:sign_in => 'login'}, :controllers => { :registrations => "registrations" }
  devise_scope :user do
    # post 'users/update_profile', :to => "registrations#update_profile"
  end

  devise_scope :user do
    get "login", :to => "devise/sessions#new"
  end

  root to: "home#index"
  get 'welcome/plans' => 'home#welcome_plans'
  get 'upgrade' => 'home#upgrade'
  get 'dashboard' => 'dashboard#index'
  post 'send_contact' => 'home#send_contact' 

  concern :rateable do
    resources :rates
  end

  resources :users
  resources :rates
  resources :letters
  resources :pictures

  resources :reservations do
    member do
      match :edit_notes, :via => [:put, :get]
    end 
  end

  resources :properties, concerns: :rateable do
    member do     
      match :pictures,  :via => [:put, :get]
      get :booking_detail
    end
    collection do
      get :tags
    end
  end

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
