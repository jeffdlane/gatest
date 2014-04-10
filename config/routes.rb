GATest::Application.routes.draw do
  devise_for :users
  resources :accounts, only: [:index]
  get '/auth/:provider/callback', to: 'accounts#create'
  root :to => "accounts#index"
end
