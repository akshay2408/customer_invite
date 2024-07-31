# spec/controllers/customers_controller_spec.rb
require 'rails_helper'

RSpec.describe CustomersController, type: :controller do
  describe 'POST #index' do
    let(:file) do
      fixture_file_upload('files/customers.txt', 'text/plain')
    end

    before do
      allow(CustomerInviterService).to receive(:call).and_return([
        { user_id: 1, name: 'Aarav Patel' },
        { user_id: 2, name: 'Vivaan Sharma' },
        { user_id: 3, name: 'Aditya Mehra' }
      ])
    end

    context 'with valid file' do
      it 'returns http success' do
        post :index, params: { file: file }
        expect(response).to have_http_status(:ok)
      end

      it 'returns the correct customers' do
        post :index, params: { file: file }
        json_response = JSON.parse(response.body)
        expect(json_response).to eq([
          { 'user_id' => 1, 'name' => 'Aarav Patel' },
          { 'user_id' => 2, 'name' => 'Vivaan Sharma' },
          { 'user_id' => 3, 'name' => 'Aditya Mehra' }
        ])
      end
    end

    context 'without file' do
      it 'returns http unprocessable entity' do
        post :index
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns an error message' do
        post :index
        json_response = JSON.parse(response.body)
        expect(json_response['error']).to eq('File not provided')
      end
    end
  end
end
