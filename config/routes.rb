Rails.application.routes.draw do
  get 'programs', to: 'programs#index'
  post 'programs', to: 'programs#create'
  get 'programs/new', to: 'programs#new'
  get 'programs/:id', to: 'programs#show', as: 'program'
  get 'directors', to: 'directors#index'
  post 'directors', to: 'directors#create'
  get 'directors/new', to: 'directors#new'
  get 'directors/:id', to: 'directors#show', as: 'director'
  get 'locations', to: 'locations#index'
  post 'locations', to: 'locations#create'
  get 'locations/new', to: 'locations#new'
  get 'locations/:id', to: 'locations#show', as: 'location'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
