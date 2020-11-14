Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :plants do
    resources :bookings, only: :create
  end

  resources :bookings do
    member do
      get 'accept'
    end
  end

  resources :bookings do
    member do
      get 'reject'
    end
  end

  get "/dashboard", to: 'pages#dashboard'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

# routes /bookings/booking_id/accept
# routes /bookings/booking_id/accept
# we don't want the route nested inside of the plants
# your bookings: bookings you've made
# your requests: bookings I've received for my plants
