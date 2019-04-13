Rails.application.routes.draw do
  root to: 'users#index'

  resources :users
  resources :questions, except: %i[show new index]
  resources :sessions, only: %i[new create destroy]

  get 'sign_up' => 'users#new'
  get 'log_in' => 'sessions#new'
  get 'log_out' => 'sessions#destroy'
end
