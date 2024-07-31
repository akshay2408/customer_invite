# app/services/customer_inviter.rb
require 'haversine'

class CustomerInviter
  MUMBAI_COORDINATES = [19.0590317, 72.7553452]
  DISTANCE_THRESHOLD = 100 # km

  def self.call(file_content)
    customers = []
    file_content.each_line do |line|
      customer = JSON.parse(line)
      if within_100km?(customer["latitude"].to_f, customer["longitude"].to_f)
        customers << { user_id: customer["user_id"], name: customer["name"] }
      end
    end
    customers.sort_by { |c| c[:user_id] }
  end

  def self.within_100km?(latitude, longitude)
    distance = Haversine.distance(MUMBAI_COORDINATES[0], MUMBAI_COORDINATES[1], latitude, longitude).to_km
    distance <= DISTANCE_THRESHOLD
  end
end