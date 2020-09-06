Rails.application.routes.draw do
  root 'programs#index'
  
  resources :programs
  resources :discs
  resources :directors
  resources :locations
  resources :series
  resources :packages
  resources :alternate_titles
  resources :program_version_clusters
  
  #reports
  get 'reports/program/duplicates', to: 'programs#duplicates_report'
  get 'reports/program/unused', to: 'programs#unused_report'
  get 'reports/disc/no_location', to: 'discs#no_location_report'
  get 'reports/package/no_discs', to: 'packages#no_discs_report'

  #modal selectors
  get "select/program/:link_id/:set_id", to: 'programs#selector', as: :program_selector
  get "select/search/program/:term", to: 'programs#selector_search', as: :program_selector_search
  get "select/director/:link_id/:set_id", to: 'directors#selector', as: :director_selector
  get "select/search/director/:term", to: 'directors#selector_search', as: :director_selector_search
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
