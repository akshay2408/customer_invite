# spec/services/customer_inviter_service_spec.rb
require 'rails_helper'

RSpec.describe CustomerInviterService do
  let(:file_content) do
    <<~DATA
      {"user_id":1,"name":"Aarav Patel","latitude":"18.602288688693122","longitude":"72.6075518864525"}
      {"user_id":2,"name":"Vivaan Sharma","latitude":"18.602594091767223","longitude":"72.60806520318829"}
      {"user_id":3,"name":"Aditya Mehra","latitude":"18.59385620790292","longitude":"72.60969846104362"}
      {"user_id":4,"name":"Vihaan Iyer","latitude":"18.592086969743228","longitude":"72.62191518797307"}
      {"user_id":5,"name":"Arjun Nair","latitude":"18.593468648143574","longitude":"72.61915990502989"}
      {"user_id":6,"name":"Sai Prasad","latitude":"18.60300546907289","longitude":"72.61185171144383"}
    DATA
  end

  describe '.call' do
    it 'returns customers within 100km of Mumbai office' do
      result = CustomerInviterService.call(file_content)
      expect(result).to eq([
        { user_id: 1, name: "Aarav Patel" },
        { user_id: 2, name: "Vivaan Sharma" },
        { user_id: 3, name: "Aditya Mehra" },
        { user_id: 4, name: "Vihaan Iyer" },
        { user_id: 5, name: "Arjun Nair" },
        { user_id: 6, name: "Sai Prasad" }
      ])
    end
  end

  describe '.within_100km?' do
    it 'returns true for a location within 100km' do
      expect(CustomerInviterService.send(:within_100km?, 18.602288688693122, 72.6075518864525)).to be true
    end

    it 'returns false for a location outside 100km' do
      expect(CustomerInviterService.send(:within_100km?, 17.385044, 78.486671)).to be false
    end
  end
end
