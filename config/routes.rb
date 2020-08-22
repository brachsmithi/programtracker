Rails.application.routes.draw do
  root 'programs#index'
  
  resources :programs
  resources :discs
  resources :directors do
    collection do
      get 'search'
    end
  end
  resources :locations
  resources :series
  resources :packages
  resources :alternate_titles
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
