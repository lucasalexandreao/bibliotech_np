Rails.application.routes.draw do  
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  root "home#index"

  devise_for :bibliotecarios, controllers: { registrations: "bibliotecarios/registrations" }

  resources :gestao_bibliotecarios, except: [ :show ]
  resources :categorias, except: [ :show ]
end
