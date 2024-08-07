# app/services/weather_service.rb

class WeatherService
  OPENWEATHERMAP_API_KEY = Rails.application.credentials.openweather[:key]
  PEXELS_API_KEY = Rails.application.credentials.pexels[:key]

  def self.fetch_weather_and_image(latitude, longitude)
    weather_data = fetch_weather_data(latitude, longitude)
    city_name = fetch_city_name(latitude, longitude)
    city_image = fetch_city_image(city_name)
    weather_icon = fetch_weather_icon(weather_data)

    {
      weather_data: weather_data,
      city_name: city_name,
      city_image: city_image,
      weather_icon: weather_icon
    }
  end

  private

  def self.fetch_weather_data(latitude, longitude)
    response = HTTParty.get("http://api.openweathermap.org/data/2.5/weather?lat=#{latitude}&lon=#{longitude}&appid=#{OPENWEATHERMAP_API_KEY}")
    JSON.parse(response.body)
  end

  def self.fetch_city_name(latitude, longitude)
    result = Geocoder.search([latitude, longitude]).first
    # logger.info "Service: #{result}"
    result&.city || "Unknown City"
  end

  def self.fetch_city_image(city_name)
    client = Pexels::Client.new(PEXELS_API_KEY)
    city_response = client.photos.search(city_name,page: 1, per_page: 1)
    city_response.photos[0].src["original"]
  end

  def self.fetch_weather_icon(weather_data)
    icon = weather_data.dig("weather", 0, "icon")
    "https://openweathermap.org/img/wn/#{icon}@2x.png"
  end
end
