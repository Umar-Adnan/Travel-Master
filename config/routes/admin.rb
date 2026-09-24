namespace :admin do
    root to: "dashboard#index"
    resources :destinations
    resources :hotels
    resources :transports
    resources :routes_infos
    resources :users
    resources :alerts
  end