Rails.application.routes.draw do
  resources :goals, except: [:show]
  resources :tasks

  root "goals#index"

  get "up" => "rails/health#show", as: :rails_health_check
end
