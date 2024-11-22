class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show edit update destroy vote]
  before_action :require_signin, except: %i[index show]
  before_action :set_coordinates, only: [:index]

  def index
    
    @articles = Article.all
    @recent_articles = Article.recent
    @most_rated_articles = Article.most_rated
    @weather_info = WeatherService.fetch_weather_and_image(@coordinates[0], @coordinates[1])

  end

   # GET /articles/1
  # GET /articles/1.json
  def show
    @likers = @article.likers
    @current_like = current_user.likes.find_by(article_id: @article.id) if current_user
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit; end

  # POST /articles
  # POST /articles.json
  def create
    @article = current_user.articles.new(article_params)

    if @article.save
      flash[:success] = 'Article was successfully created.'
      redirect_to @article
    else
      render :new
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    if @article.update(article_params)
      flash[:success] = 'Article was successfully updated.'
      redirect_to @article
    else
      render :edit
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    redirect_to articles_url
    flash[:danger] = 'Article was successfully destroyed.'
  end

  def vote
    if !current_user.liked? @article
      @article.liked_by current_user
    elsif current_user.liked? @article
      @article.unliked_by current_user
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
