Secondhouz::Application.routes.draw do
  
  devise_for :users, :path_names => {:sign_in => 'login'}

  devise_scope :user do
    get "login", :to => "devise/sessions#new"

  end

  root 'home#index'

  get 'welcome/plans' => 'home#welcome_plans'
  get 'dashboard' => 'dashboard#index'

  resources :properties

  get "404", :to => "errors#not_found"
  get "500", :to => "errors#server_error"
end
