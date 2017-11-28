Rails.application.routes.draw do
  resources :historical_caps do
    member do 
      get 'resend'
    end
  end

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


  root to: 'cap_forms#new'
end

