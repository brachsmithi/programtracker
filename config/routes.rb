Rails.application.routes.draw do
  get 'locations', to: 'locations#index'
  post 'locations', to: 'locations#create'
  get 'locations/new', to: 'locations#new'
  get 'locations/:id', to: 'locations#show', as: 'location'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
