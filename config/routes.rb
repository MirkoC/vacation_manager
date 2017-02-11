Rails.application.routes.draw do
  devise_for :managers, controllers: {
    sessions: 'manager/sessions',
    registrations: 'manager/registrations'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
