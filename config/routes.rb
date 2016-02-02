Rails.application.routes.draw do
    root :to => "contracts#index"
  resources :contracts do
  end
  resources :agencies do
  end
  get '/json' => 'contracts#json'
  get '/json/:id' => 'contracts#show'
  get "/totalNum" => "numbers#index"
end
