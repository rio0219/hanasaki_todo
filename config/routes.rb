Rails.application.routes.draw do
  devise_for :users
  resources :goals, except: [:show] do
    member do
      get :record
      get :records_data
      post :record, action: :record_submit
    end
  end

  resources :tasks

  root "goals#index"

  get "up" => "rails/health#show", as: :rails_health_check
end
