Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get 'about', to: 'pages#about'
  get 'contact', to: 'pages#contact'

  resources :astros do
    collection do
      post :index
    end
    collection do
      get :listed_astros
    end
    resources :bookings, only: %i[new create]
  end

  resources :bookings, only: %i[index] do
    collection do
      get :hosted_astros
    end
  end

  put 'confirm_booking/:id', as: :confirm_booking, to: 'bookings#confirm'
  put 'reject_booking/:id', as: :reject_booking, to: 'bookings#reject'
end
