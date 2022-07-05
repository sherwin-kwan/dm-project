class ApplicationController < ActionController::Base
  helper_method :get_path

  def get_path(path_prefix, options = {})
    return Rails.application.routes.url_helpers.send("#{path_prefix}_path", options)
  end
end
