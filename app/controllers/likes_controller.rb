class LikesController < ApplicationController
    before_action :require_signin, only: [:create, :destroy]
    before_action :set_article, only: [:create, :destroy]
    def create
        @article.likes.create!(user: current_user)
        flash[:success] = 'Glad! you liked it!'
        redirect_to @article
      end
    
      def destroy
        like = current_user.likes.find(params[:id])
        like.destroy
        flash[:danger] = 'Sorry! you unliked it!'
        redirect_to @article
      end

    private 
    def set_article 
        
        @article = Article.find(params[:article_id])
    end
end
