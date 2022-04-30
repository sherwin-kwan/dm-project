class ArticlesController < ApplicationController
  def index
    @articles = Article.all.order("created_at DESC")
  end

  def show
    if params[:id].to_i > 0
      @article = Article.find(params[:id])
    else
      @article = Article.where(slug: params[:id]).first
    end
  end
end