Rails.application.routes.draw do
  resources :event_amenities
  resources :amenities
  resources :locations
  resources :events
  resources :users,except: [:index]
  post '/users' => 'users#create'
  match '/add-guest', to: 'events#add_guest',via: [:get, :post]

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  get '/signup' => 'users#new'
  post '/users' => 'users#create'

  root 'events#notice'
  resources :rsvps, only: :update

  get '/sales' => 'users#sales'
  get '/manage/events' => 'events#all'
  get '/manage/amenities' => 'amenities#all'
  get '/manage/locations' => 'locations#all'
  get '/manage/users' => 'users#all'

end
