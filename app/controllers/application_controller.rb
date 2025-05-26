class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  before_action :set_user_location

  def set_user_location
    user_ip = request.remote_ip

    # Skip local IP addresses
    if local_ip?(user_ip)
      #put code here 
      return
    end

    if request.location.present?
      begin
        @user_latitude = request.location.latitude
        @user_longitude = request.location.longitude
        location_info = Geocoder.search([@user_latitude, @user_longitude])
        @user_city = location_info.first&.city
  
      #   # Fetch city image from Unsplash
        # search_results = Pexels::Photo.search(@user_city, per_page: 1)
        # client = Pexels::Client.new(Rails.application.credentials.pexels)
        # search_results = client.photos.search(@user_city, per_page: 1)
        # @city_image_url = search_results.photos.first
  
        rescue => e
          Rails.logger.error "**********************************************Error********************************"
          Rails.logger.error "Error in set_user_location: #{e.message}"
          Rails.logger.error e.backtrace.join("\n")
        end
    end

  end


    private

    def local_ip?(ip)
      # Check if the IP is a local address
      ['127.0.0.1', '::1'].include?(ip) || ip.start_with?('192.168.', '10.', '172.16.', '172.31.')
    end

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
