Rails.application.routes.draw do
  authenticate :user do
    resources :historical_caps, only: [:new, :create, :edit, :update, :destroy] do
      member do
        get 'resend'
      end
    end
  end

  resources :historical_caps, only: [:index, :show]

  devise_for :users
  scope "/admin" do
    resources :users
  end
  resources :cap_forms, only: [:new, :create]

  namespace :api do
    namespace :v1 do
      resources :cap_alerts, only: [:create]
    end
  end

  get 'test_cap' => 'application#test_cap'


  root to: '#new'
end
