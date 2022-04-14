class Admin::ArticlesController < ApplicationController
  def index
    @articles = Article.all.order("created_at DESC")
  end

  def create
    @article = Article.new(permitted_params)
    if @article.save
      redirect_to admin_articles_path
    else
      render :new, status: 400
      # TODO: Add a flash to handle errors
    end
  end

  def destroy
    if @article.destroy
      redirect_to admin_articles_path
      # TODO: Notify user that deleted successfully
    else
      flash[:errors] = "Unable to delete, #{@article.errors&.full_messages}"
      redirect_to admin_articles_path
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
    if @article.update(permitted_params)
      redirect_to admin_articles_path
    else
      render :edit, status: 400
    end
  end

  private

  def permitted_params
    params.require(:article).permit([:title, :body])
  end
end
