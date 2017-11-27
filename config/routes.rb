Rails.application.routes.draw do
  resources :historical_caps
  devise_for :users
  resources :users

  resources :cap_forms, only: [:new, :create]

  namespace :api do
    namespace :v1 do
      resources :cap_alerts, only: [:create]
    end
  end

  get 'test_cap' => 'application#test_cap'


  root to: 'users#index'
end

