Rails.application.routes.draw do
  root 'programs#index'
  
  resources :programs
  resources :discs
  resources :persons
  resources :locations
  resources :series
  resources :packages
  resources :alternate_titles
  resources :program_version_clusters

  #cloning
  get '/program/:id/new_version', to: 'programs#new_version', as: :program_new_version

  #reports
  get 'reports/program/duplicates', to: 'programs#duplicates_report'
  get 'reports/program/unused', to: 'programs#unused_report'
  get 'reports/disc/no_location', to: 'discs#no_location_report'
  get 'reports/package/no_discs', to: 'packages#no_discs_report'

  #modal selectors
  get "select/program/:link_id/:set_id", to: 'programs#selector', as: :program_selector
  get "select/search/program/:term", to: 'programs#selector_search', as: :program_selector_search
  get "select/person/:link_id/:set_id", to: 'persons#selector', as: :person_selector
  get "select/search/person/:term", to: 'persons#selector_search', as: :person_selector_search
  get "select/series/:link_id/:set_id", to: 'series#selector', as: :series_selector
  get "select/search/series/:term", to: 'series#selector_search', as: :series_selector_search
  get "select/package/:link_id/:set_id", to: 'packages#selector', as: :package_selector
  get "select/search/package/:term", to: 'packages#selector_search', as: :package_selector_search
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
