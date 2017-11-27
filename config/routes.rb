Rails.application.routes.draw do
  devise_for :users
  resources :users

  get 'submission' => 'submission#new'

  namespace :api do
    namespace :v1 do
      resources :cap_alerts, only: [:create]
    end
  end

  get 'test_cap' => 'application#test_cap'


  root to: 'users#index'
end

