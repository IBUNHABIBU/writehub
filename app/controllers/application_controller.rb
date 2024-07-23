class ApplicationController < ActionController::Base
    
  before_action :set_user_location

  def set_user_location
  
    if request.location.present?
      @user_latitude = request.location.latitude
      @user_longitude = request.location.longitude

      location_info = Geocoder.search([@user_latitude, @user_longitude])
      @user_city = location_info.first&.city

    #   # Fetch city image from Unsplash
      # search_results = Pexels::Photo.search(@user_city, per_page: 1)
      
    logger.info '*********************** Rendering the applicaton controller ********************'
    logger.info 'Set location'
    
    if local_ip?(user_ip)
      Rails.logger.debug "Local IP detected: #{user_ip}"
      return
    end
      client = Pexels::Client.new(Rails.application.credentials.pexels[:key])
      
      Rails.logger.debug "Local IP detected: #{@user_latitude} #{location_info}******************* "
      search_results = client.photos.search(@user_city, per_page: 1)
      @city_image_url = search_results.photos.first

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
