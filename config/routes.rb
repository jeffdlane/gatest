GATest::Application.routes.draw do
  resources :properties
  resources :upload, only: [:new, :create]
  devise_for :users
  resources :accounts, only: [:index]
  get '/auth/:provider/callback', to: 'accounts#create'
  root :to => "accounts#index"
end
