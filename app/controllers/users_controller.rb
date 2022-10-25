class UsersController < ApplicationController

  def create
    @user = User.new(permitted_params)
    if @user.save
      redirect_to users_path
    else
      redirect_to new_user_path
      # display error to user
    end
  end

  def new
    @user = User.new
  end

  def permitted_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
