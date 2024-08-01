# app/controllers/customers_controller.rb
class CustomersController < ApplicationController
  def process_customers
    if params[:file].present?
      file = params[:file].read
      @customers = CustomerInviterService.call(file)
      render json: @customers, status: :ok
    else
      render json: { error: 'File not provided' }, status: :unprocessable_entity
    end
  end
end