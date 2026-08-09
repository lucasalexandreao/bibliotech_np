Rails.application.routes.draw do  
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  root "home#index"

  devise_for :bibliotecarios, controllers: { registrations: "bibliotecarios/registrations" }

  resources :gestao_bibliotecarios, except: [ :show ]
  resources :categorias, except: [ :show ]
  resources :usuarios

  resources :livros do
    resources :emprestimos, only: [ :new, :create ]
  end

  resources :emprestimos, only: [ :index ] do
    member do
      patch :devolver
      patch :renovar
    end
  end

  # Rotas do Portal do Leitor
  get 'portal', to: 'portal#login', as: 'portal_login'
  post 'portal/autenticar', to: 'portal#autenticar', as: 'portal_autenticar'
  delete 'portal/logout', to: 'portal#logout', as: 'portal_logout'
  
  get 'portal/meus_emprestimos', to: 'portal#meus_emprestimos', as: 'portal_meus_emprestimos'
  patch 'portal/renovar/:id', to: 'portal#renovar', as: 'portal_renovar'
end
