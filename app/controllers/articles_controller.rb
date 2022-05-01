class ArticlesController < ApplicationController
  def index
    @articles = Article.all.order("created_at DESC")
  end

  def show
    @article = Article.find_by_slug_or_id(params[:id])
  end
end