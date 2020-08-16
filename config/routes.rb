Rails.application.routes.draw do
  root 'programs#index'
  resources :programs
  resources :discs
  resources :directors
  resources :locations
  resources :series
  resources :packages
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
