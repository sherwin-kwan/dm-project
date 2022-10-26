module Admin
  class UsersController < AdminController
    def index
      @users = User.all
    end

    def dashboard
      @user = get_object
    end
  end
end