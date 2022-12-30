Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :astros do
    resources :bookings, only: %i[new create index destroy] do
      collection do
        get :list_astros
        get :astros_host
      end
    end
  end

  put "confirm_booking/:id", as: :confirm_booking, to: "bookings#confirm"
  put "reject_booking/:id", as: :reject_booking, to: "bookings#reject"
end
