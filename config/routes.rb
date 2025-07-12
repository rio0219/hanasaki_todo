Rails.application.routes.draw do
  resources :goals, except: [:show] do
    member do
      get :record
      post :record, action: :record_submit
    end
  end

  resources :tasks

  root "goals#index"

  get "up" => "rails/health#show", as: :rails_health_check
end
