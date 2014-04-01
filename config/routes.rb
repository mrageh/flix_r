Flix::Application.routes.draw do

  root "movies#index"

  get '/signup' => 'users#new'

  get '/signin' => 'sessions#new'
  post 'sessions' => 'sessions#create'

  resources :users
  resources :movies do
    resources :reviews
  end
end
