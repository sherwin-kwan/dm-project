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
end
