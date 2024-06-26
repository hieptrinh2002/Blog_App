Rails.application.routes.draw do
  get 'users/profile'
  devise_for :users, controllers:{
    session:"users/sessions",
    registrations:"users/registrations"
  }

  # post/1/comments/4
  resources :posts do 
    resources :comments
  end


  #get 'home', to: 'pages#home'
  get 'about', to: 'pages#about'
  get 'u/profile/:id', to: 'users#profile', as:"user" #{as dung de dat lai ten user_path(id: 1) #=> "/u/1"}

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "pages#home"
end
