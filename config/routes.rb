Rails.application.routes.draw do
  
  namespace :site do
    get 'welcome/index'
    get 'search', to: 'search#questions'
    get 'subject/:subject_id/:subject', to: 'search#subject', as: 'search_subject' # o as define o nome do path da rota, diferente do nome padrão definido, após sua criação.
    post 'answer', to: 'answer#question'
  end
  
  namespace :admins_backoffice do
    get 'welcome/index'
    resources :admins #name of the controller - resources REST - CREATE, READ, UPDATE, DELETE
    resources :subjects
    resources :questions
  end
  devise_for :admins, skip: [:registrations]
 
  namespace :users_backoffice do
    get 'welcome/index'
    get 'profile', to: 'profile#edit'
    patch 'profile', to: 'profile#update'
  end
  devise_for :users

  get 'inicio', to: 'site/welcome#index'

  root to: 'site/welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
