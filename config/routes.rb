Rails.application.routes.draw do
  devise_for :managers, controllers: {
    sessions: 'manager/sessions',
    registrations: 'manager/registrations'
  }

  resources :vacations, only: [:create]
end
