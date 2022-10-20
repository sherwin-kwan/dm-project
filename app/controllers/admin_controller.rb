class AdminController < ApplicationController
  before_action :check_for_admin

  def check_for_admin
    unless logged_in?
      flash[:alert] = "You need to log in to view this page"
      redirect_to login_path
    end
  end
end
                        