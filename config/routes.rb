Rails.application.routes.draw do
  
  root "translations#index"

  get "/translations", to: "translations#index"

  resources :translations

end
