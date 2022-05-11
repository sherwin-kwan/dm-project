class ArticlesController < ApplicationController
  def index
    @articles = Article.all.order("created_at DESC")
  end

  def show
    @article = Article.find(params[:id].to_i)
    # To handle "old" slugs after a title has changed, redirect any URL requested which contains a "-" to the latest canonical URL
    if params[:id].include?("-") && !article_path(@article).include?(params[:id])
      redirect_to article_path(@article)
    end
  end
end