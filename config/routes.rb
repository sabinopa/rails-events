Rails.application.routes.draw do
  devise_for :clients, controllers: {
    sessions: 'clients/sessions',
    registrations: 'clients/registrations'
  }
  devise_for :suppliers, controllers: {
    sessions: 'suppliers/sessions',
    registrations: 'suppliers/registrations'
  }

  root 'home#index'

  resources :companies, shallow: true, only: [:new, :create, :edit, :update, :show] do
    get 'search', on: :collection

    resources :event_types, only: [:new, :create, :show, :edit, :update] do
      member do
        delete :remove_photo
      end
      resources :event_pricings, only: [:new, :create, :show, :edit, :update]
      resources :orders, only: [:new, :create, :show] do
        resources :order_approvals, only: [:approve]
      end
    end
  end

  scope :client do
    get :my_orders, to: 'orders#my_orders'
  end

  scope :supplier do
    get :my_company_orders, to: 'orders#my_company_orders'
  end
end