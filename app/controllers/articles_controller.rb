class ArticlesController < ApplicationController
  def index
    @article_limit = 5
    @page = params[:page].to_i
    @num_of_pages = (Article.count - 1) / @article_limit + 1
    if @page < 0 || @page >= @num_of_pages
      redirect_to :error
    end
    @articles = Article.all.order("created_at DESC").offset(@article_limit * @page).limit(@article_limit)
  end

  def show
    @article = Article.find(params[:id].to_i)
    # To handle "old" slugs after a title has changed, redirect any URL requested which contains a "-" to the latest canonical URL
    if params[:id].include?("-") && !article_path(@article).include?(params[:id])
      redirect_to article_path(@article)
    end
  end

  def error

  end
end