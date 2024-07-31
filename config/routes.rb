# config/routes.rb
Rails.application.routes.draw do
  resources :customers, only: [:index]
end