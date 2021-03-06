Rails.application.routes.draw do
  resources :transactions
  resources :coins
  resources :users, only: [:create, :show]

  post '/signup', to: 'users#create'
  post '/login', to: 'auth#create'
  get '/persist', to: 'auth#show'

  get 'users/coins/:id', :to => 'users#coins'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
