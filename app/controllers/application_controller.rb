class ApplicationController < ActionController::Base
    
  before_action :set_user_location

  def set_user_location
    if request.location.present?
      @user_latitude = request.location.latitude
      @user_longitude = request.location.longitude
      
      # @user_latitude = -6.75234
      # @user_longitude = 39.2396
      location_info = Geocoder.search([@user_latitude, @user_longitude])
      @user_city = location_info.first&.city

    #   # Fetch city image from Unsplash
      # search_results = Pexels::Photo.search(@user_city, per_page: 1)
      client = Pexels::Client.new(Rails.application.credentials.pexels[:key])
      search_results = client.photos.search(@user_city, per_page: 1)
      @city_image_url = search_results.photos.first
    end
  end

    private

    def current_user
        User.find(session[:user_id]) if session[:user_id]
    end

    def require_signin
        unless current_user
            session[:intended_url] = request.url
            redirect_to login_path, alert: "Please sign in first!"
        end
    end

    def current_user?(user)
        current_user == user
    end

    def current_user_admin?
        current_user && current_user.admin
    end

    def require_admin
        unless current_user_admin?
          redirect_to root_path, notice: "Unauthorized access"
        end
    end

    helper_method :current_user_admin?
    helper_method :current_user?
    helper_method :current_user
end
