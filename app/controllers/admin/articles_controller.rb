class Admin::ArticlesController < ApplicationController
  def index
    @articles = Article.all.order("created_at DESC")
  end

  def create
    @article = Article.new(permitted_params)
    if @article.save
      redirect_to admin_articles_path
    else
      puts "Something went wrong"
      # TODO: Add a flash to handle errors
    end
  end

  def destroy
    if @article.destroy
      redirect_to admin_articles_path
      # TODO: Notify user that deleted successfully
    else
      puts "Something went wrong"
      # TODO: Add a flash
    end
  end

  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    @article.update(permitted_params)
    redirect_to admin_articles_path
  end

  private

  def permitted_params
    params.require(:article).permit([:title, :body])
  end
end
