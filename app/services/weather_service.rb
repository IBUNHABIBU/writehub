# app/services/weather_service.rb
require 'pixabay_api'

class WeatherService
  OPENWEATHERMAP_API_KEY = ENV["OPEN_WEATHER"]
  PIXABAY_API_KEY = ENV["PIXABAY"]

  def self.fetch_weather_and_image(latitude, longitude)
    weather_data = fetch_weather_data(latitude, longitude)
    city_name = fetch_city_name(latitude, longitude)
    city_info = fetch_city_name(latitude, longitude)
    city_image = fetch_city_image(city_name)
    weather_icon = fetch_weather_icon(weather_data)

    {
      weather_data: weather_data,
      city_name: city_name,
      country_name: city_info[:country],
      city_image: city_image,
      weather_icon: weather_icon,
      
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
    city = result&.city || "Unknown City"
    country = result&.country || "Unknown Country"
    
    { city: city, country: country }
  end

  def self.fetch_city_image(city_name)
    client = PixabayApi::ImagesApi.new
    
    response = client.find(keyword: city_name[:city] || city_name[:country] )
   
    image_info = response.body['hits'].first

    {
      image_url: image_info['largeImageURL'],
      photographer: image_info['user'],
      photographer_url: image_info['userImageURL']
    }
  end
  
  def self.fetch_weather_icon(weather_data)
    icon = weather_data.dig("weather", 0, "icon")
    "https://openweathermap.org/img/wn/#{icon}@2x.png"
  end
end
