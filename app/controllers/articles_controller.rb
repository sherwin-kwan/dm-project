class ArticlesController < ApplicationController
  def index
    @page = params[:page].to_i
    @limit = params[:limit]&.to_i || 5
    @num_of_pages = (Article.count - 1) / @limit + 1
    if (@page < 0 || @page >= @num_of_pages) && @num_of_pages > 0
      render :error, status: 404
    end
    @articles = Article.all.order("created_at DESC").offset(@limit * @page).limit(@limit)
  end

  def show
    @article = Article.find_by(id: params[:id].to_i)
    if !@article
      render :error, status: 404 and return
    end
    # To handle "old" slugs after a title has changed, redirect any URL requested which contains a "-" to the latest canonical URL
    if params[:id].include?("-") && !article_path(@article).include?(params[:id])
      redirect_to article_path(@article)
    end
  end

  def error
    # To be continued. Right now it just renders the error view.
  end
end