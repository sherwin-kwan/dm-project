module Paginatable
  def set_up_pagination(model)
    @page = params[:page].to_i
    @limit = params[:limit]&.to_i || 5
    @num_of_pages = (model.count - 1) / @limit + 1
    if (@page < 0 || @page >= @num_of_pages) && @num_of_pages > 0
      render :error, status: 404
    end
    @articles = model.all.offset(@limit * @page).limit(@limit)
  end
end