Rails.application.routes.draw do
  root 'programs#index'
  
  resources :programs
  resources :discs
  resources :directors
  resources :locations
  resources :series
  resources :packages
  resources :alternate_titles
  
  #reports
  get 'reports/program/duplicates', to: 'program#duplicates_report'
  get 'reports/program/unused', to: 'program#unused_report'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
