Flix::Application.routes.draw do

  root "movies#index"

  get 'signup' => 'users#new'

  get 'signin' => 'sessions#new'
  post 'sessions' => 'sessions#create'
  delete 'signout' => 'sessions#destroy'

  resources :users
  resources :movies do
    resources :reviews
    resources :favourites
  end
end
