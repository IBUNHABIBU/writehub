json.extract! user_location, :id, :latitude, :longitude, :city, :created_at, :updated_at
json.url user_location_url(user_location, format: :json)
