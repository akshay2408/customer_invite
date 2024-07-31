# app/services/customer_inviter_service.rb
require 'haversine'

class CustomerInviterService
  MUMBAI_COORDINATES = [19.0590317, 72.7553452]
  DISTANCE_THRESHOLD = 100 # km

  def self.call(file_content)
    customers = []
    file_content.each_line do |line|
      customer = JSON.parse(line)
      latitude = customer["latitude"].to_f
      longitude = customer["longitude"].to_f
      if within_100km?(latitude, longitude)
        customers << { user_id: customer["user_id"], name: customer["name"] }
      end
    end
    customers.sort_by { |c| c[:user_id] }
  end

  private

  def self.within_100km?(latitude, longitude)
    distance = haversine_distance(MUMBAI_COORDINATES[0], MUMBAI_COORDINATES[1], latitude, longitude)
    distance <= DISTANCE_THRESHOLD
  end

  def self.haversine_distance(lat1, lon1, lat2, lon2)
    rad_per_deg = Math::PI / 180
    rm = 6371 # Earth radius in kilometers

    lat1_rad = lat1 * rad_per_deg
    lon1_rad = lon1 * rad_per_deg
    lat2_rad = lat2 * rad_per_deg
    lon2_rad = lon2 * rad_per_deg

    value = Math.sin((lat2_rad - lat1_rad) / 2)**2 +
        Math.cos(lat1_rad) * Math.cos(lat2_rad) *
        Math.sin((lon2_rad - lon1_rad) / 2)**2

    other_value = 2 * Math::atan2(Math::sqrt(value), Math::sqrt(1 - value))
    rm * other_value
  end
end
