# config/routes.rb
Rails.application.routes.draw do
  post 'customers', to: 'customers#process_customers'
end