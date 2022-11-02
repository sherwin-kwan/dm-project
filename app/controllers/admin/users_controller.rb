module Admin
  class UsersController < AdminController
    def index
      @users = User.all
    end

    def dashboard
      render :error unless current_user.id == params[:id].to_i
      @user = get_object
    end
  end
end