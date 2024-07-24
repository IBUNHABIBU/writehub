class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show edit update destroy vote]
  before_action :require_signin, except: %i[index show]
  before_action :set_coordinates, only: [:index, :update_coordinates]

  def index
    @articles = Article.all
    @recent_articles = Article.recent
    @most_rated_articles = Article.most_rated
    @weather_info = WeatherService.fetch_weather_and_image(@coordinates[0], @coordinates[1])

    logger.info "*************** Coordinates *********************"
    logger.info "*************** #{@coordinates} *********************"
    logger.info "*************** Weather info #{@weather_info} *********************"
  end

  def update_coordinates
    session[:coordinates] = [params[:latitude].to_f, params[:longitude].to_f]
    logger.info "********************Session of coordinates #{session[:coordinates]}"
    respond_to do |format|
      format.json { render json: { message: 'Coordinates updated successfully' } }
    end
  end

  private

  def set_coordinates
    @coordinates = session[:coordinates] || [25.276987, 55.296249] # Default coordinates
  end

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :content, :image, :user_id, category_ids: [])
  end
end
