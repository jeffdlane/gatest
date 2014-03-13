GATest::Application.routes.draw do
  resources :accounts, only: [:index, :new] do
    get 'callback' => :create, on: :collection
  end
end
