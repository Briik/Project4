Rails.application.routes.draw do
    root :to => "contracts#index"
  resources :contracts do
  end
  get "/totalNum" => "numbers#index"
end
