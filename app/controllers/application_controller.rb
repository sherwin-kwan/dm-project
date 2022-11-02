class ApplicationController < ActionController::Base
  helper_method :get_path
  helper_method :current_user
  helper_method :logged_in?

  def get_path(path_prefix, options = {})
    return Rails.application.routes.url_helpers.send("#{path_prefix}_path", options)
  end

  def current_user
    @user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    current_user.present?
  end

  # On a controller that follows Rails naming conventions ("UsersController"), this will return the corresponding model ("User")
  def my_model
    Object.const_get(self.class.to_s.gsub("Controller", "").gsub("Admin::", "").singularize)
  end

  def error
    # To be continued. Right now it just renders the error view.
  end
  
  def get_object
    id = id.to_i
    obj = my_model.find_by(id: params[:id].to_i)
    if obj
      return obj
    else
      render :error, status: 404 and return
    end
  end
end
