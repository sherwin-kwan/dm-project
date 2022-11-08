class Admin::ArticlesController < AdminController
  include Paginatable
  include ActionView::Helpers::SanitizeHelper

  def index
    set_up_pagination(Article)
    @articles = @articles.order("created_at DESC")
  end

  def create
    @article = Article.new(permitted_params)
    @article.author = current_user.person
    if @article.save
      redirect_to admin_articles_path
    else
      flash[:errors] = "Article could not be created, #{@article.errors&.full_messages}"
      render :new, status: 400
    end
  end

  def destroy
    @article = Article.find(params[:id].to_i)
    if @article.destroy
      redirect_to admin_articles_path
      # TODO: Notify user that deleted successfully
    else
      flash[:errors] = "Article could not be dstroyed, #{@article.errors&.full_messages}"
      redirect_to admin_articles_path
    end
  end

  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id].to_i)
  end

  def update
    @article = Article.find(params[:id].to_i)
    if @article.update(permitted_params)
      redirect_to admin_articles_path
    else
      flash[:errors] = "Article could not be updated, #{@article.errors&.full_messages}"
      render :edit, status: 400
    end
  end

  private

  def permitted_params
    params.require(:article).permit([:title, :body]).tap{|p| p[:body] = sanitize(p[:body])}
  end
end
