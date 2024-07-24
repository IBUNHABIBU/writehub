class LocationsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :update_coordinates

  def update_coordinates
    session[:coordinates] = [params[:latitude].to_f, params[:longitude].to_f]
    render json: { message: "Coordinates updated successfully #{session[:coordinates]}" }
  end
end
