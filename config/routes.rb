Rails.application.routes.draw do
  devise_for :users
  resources :users

  get 'submission' => 'submission#new'
  get 'test_cap' => 'application#test_cap'


  root to: 'users#index'
  
end

