Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :astros, only: %i[home index show new create edit update destroy] do
    resources :bookings, only: %i[new create]
      collection do
        get :list_astros
      end
  end

  resources :bookings, only: %i[index destroy] do
    collection do
      get :astros_host
    end
  end

  put "confirm_booking/:id", as: :confirm_booking, to: "bookings#confirm"
  put "reject_booking/:id", as: :reject_booking, to: "bookings#reject"
end
