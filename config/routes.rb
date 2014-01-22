Secondhouz::Application.routes.draw do
  
  devise_for :users, :path_names => {:sign_in => 'login'}

  devise_scope :user do
    get "login", :to => "devise/sessions#new"

  end

  root 'home#index'

  get 'welcome/plans' => 'home#welcome_plans'
  get 'dashboard' => 'dashboard#index'

  resources :properties do
    member do
      get :rates
      get :pictures
    end
    collection do

    end
  end

  #seems not to be working =(
  get '400', :to => 'errors#not_found'
  get '500', :to => 'errors#internal_server_error'
end
