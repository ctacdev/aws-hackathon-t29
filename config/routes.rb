Rails.application.routes.draw do
  devise_for :users

  authenticate :user do
    resources :historical_caps, only: [:edit, :update, :destroy] do
      member do
        get 'resend'
      end
    end

    resources :cap_forms, only: [:new, :create]

    scope "/admin" do
      resources :users
    end
  end

  resources :historical_caps, only: [:index, :show]

  namespace :api do
    namespace :v1 do
      resources :cap_alerts, only: [:create]
    end
  end

  get 'test_cap' => 'application#test_cap'

  root to: 'historical_caps#index'
end
