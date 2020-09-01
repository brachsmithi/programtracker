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
  get 'reports/program/duplicates', to: 'programs#duplicates_report'
  get 'reports/program/unused', to: 'programs#unused_report'
  get 'reports/disc/no_location', to: 'discs#no_location_report'
  get 'reports/package/no_discs', to: 'packages#no_discs_report'

  #modal selectors
  get "select/program/:link_id/:set_id" => 'programs#selector', :as => :program_selector
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
