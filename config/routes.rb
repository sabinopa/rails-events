Rails.application.routes.draw do
  devise_for :suppliers, controllers: {
    sessions: 'suppliers/sessions',
    registrations: 'suppliers/registrations'
  }

  root 'home#index'

  resources :companies, shallow: true, only: [:new, :create, :edit, :update, :show] do
    resources :event_types, only: [:new, :create, :show, :edit, :update] do
      resources :event_pricings, only: [:new, :create, :show, :index]
    end
  end
end