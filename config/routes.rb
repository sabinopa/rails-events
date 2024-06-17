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

  resources :companies, shallow: true, only: %i[new create edit update show] do
    get 'search', on: :collection
    get 'company_reviews', on: :member
    post 'active', on: :member
    post 'inactive', on: :member

    resources :event_types, only: %i[new create show edit update] do
      post 'active', on: :member
      post 'inactive', on: :member
      member do
        delete 'remove_photo'
      end
      resources :event_pricings, only: %i[new create show edit update]
      resources :orders, only: %i[new create show] do
        get :approve, on: :member
        post :approve, on: :member
        post :confirm, on: :member
        post :cancel, on: :member
        resources :reviews, only: %i[new create]
        resources :messages, only: %i[index create]
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
      resources :companies, only: %i[show index create] do
        get 'search', on: :collection
        resources :event_types, only: %i[index show] do
          get 'availability', on: :member
        end
      end
    end
  end
end
