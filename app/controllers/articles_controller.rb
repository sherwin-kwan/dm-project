class ArticlesController < ApplicationController
  include Paginatable

  def index
    set_up_pagination(Article)
    @articles = @articles.order("created_at DESC")
  end

  def show
    @article = Article.find_by(id: params[:id].to_i)
    unless @article
      render :error, status: 404 and return
    end
    # To handle "old" slugs after a title has changed, redirect any URL requested which contains a "-" to the latest canonical URL
    if params[:id].include?("-") && !article_path(@article).include?(params[:id])
      redirect_to article_path(@article)
    end
  end

end