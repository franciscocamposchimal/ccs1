Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: { registrations: "registrations"}
  resources :records
  root :to => "clients#index"

  resources :payments
  resources :avals


  resources :clients do
  	resources :warranties
    get 'renovar', on: :member
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
