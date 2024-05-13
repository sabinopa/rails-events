Rails.application.routes.draw do
  devise_for :clients, controllers: {
    sessions: 'clients/sessions',
    registrations: 'clients/registrations'
  }
  devise_for :owners, controllers: {
    sessions: 'owners/sessions',
    registrations: 'owners/registrations'
  }

  root 'home#index'

  resources :companies, shallow: true, only: [:new, :create, :edit, :update, :show] do
    get 'search', on: :collection
    post 'active', on: :member
    post 'inactive', on: :member

    resources :event_types, only: [:new, :create, :show, :edit, :update] do
      post 'active', on: :member
      post 'inactive', on: :member
      member do
        delete 'remove_photo'
      end
      resources :event_pricings, only: [:new, :create, :show, :edit, :update]
      resources :orders, only: [:new, :create, :show] do
        get :approve, on: :member
        post :approve, on: :member
        post :confirm, on: :member
        post :cancel, on: :member
        resources :messages, only: [:index, :create]
      end
    end
  end

  scope :client do
    get :my_orders, to: 'orders#my_orders'
  end

  scope :owner do
    get :my_company_orders, to: 'orders#my_company_orders'
  end

  namespace :api do
    namespace :v1 do
      resources :companies, only: [:show, :index] do
        get 'search', on: :collection
        resources :event_types, only: [:index, :show] do
          get 'availability', on: :member
        end
      end
    end
  end
end