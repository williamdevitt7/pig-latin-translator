Rails.application.routes.draw do
  root "translations#new"

  get "/translations", to: "translations#new"
end
