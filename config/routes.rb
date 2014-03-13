GATest::Application.routes.draw do
  resources :accounts, only: [:index]
  get '/auth/:provider/callback', to: 'accounts#create'
end
