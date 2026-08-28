Rails.application.routes.draw do
  # Health check
  get "up" => "rails/health#show", as: :rails_health_check

  # Root Landing Page
  root "home#index"

  # Authentication
  get "login", to: "sessions#new", as: :login
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy", as: :logout
  get "signup", to: "registrations#new", as: :signup
  post "signup", to: "registrations#create"
  resource :profile, only: [:show, :edit, :update]

  # Destinations
  resources :destinations, only: [:index, :show]

  # Trips & Itinerary Builder
  resources :trips do
    resources :trip_bookings, only: [:create, :destroy, :update]
    member do
      get :itinerary
      get :cost_breakdown
      post :auto_estimate
      get :print_view
    end
  end

  # Dedicated Cost Estimator Tool
  resources :cost_estimators, only: [:index, :create]

  # Hotels & Accommodations
  resources :hotels, only: [:index, :show] do
    member do
      post :add_to_trip
    end
  end

  # Transportation & Rentals
  resources :transports, only: [:index, :show] do
    member do
      post :add_to_trip
    end
  end

  # Route Planning & Road Conditions
  resources :routes, only: [:index, :show]

  # Weather Forecasts & Advisory
  resources :weather, only: [:index, :show]

  # Tourist Crowd Analysis
  resources :crowds, only: [:index, :show]

  # Alerts & Notifications Center
  resources :alerts, only: [:index, :update, :destroy] do
    collection do
      post :mark_all_read
    end
  end

  # Administration Portal
  namespace :admin do
    root to: "dashboard#index"
    resources :destinations
    resources :hotels
    resources :transports
    resources :routes_infos
    resources :users
    resources :alerts
  end
end
