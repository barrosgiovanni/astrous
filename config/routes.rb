Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :astros do
    collection do
      post :index
    end
    resources :bookings, only: %i[new create]
  end

  resources :bookings, only: %i[index show destroy update]

  namespace :my do
    resources :astros, only: %i[index]
    resources :bookings, only: %i[index update]
  end
end
