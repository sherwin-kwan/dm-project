class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def create
    @article = Article.new(permitted_params)
    if @article.save
      redirect_to articles_path
    else
      puts "Something went wrong"
      # TODO: Add a flash to handle errors
    end
  end

  def new
    @article = Article.new
  end

  def show
    @article = Article.find(params[:id])
  end

  private

  def permitted_params
    params.require(:article).permit([:title, :body])
  end
end
