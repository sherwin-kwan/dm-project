class UsersController < ApplicationController

  def create
    @user = User.new(permitted_params)
    if @user.save
      @user.create_person!
      redirect_to users_path
    else
      redirect_to new_user_path
      # display error to user
    end
  end

  def new
    @user = User.new
  end

  def after_password_reset
  end

  def send_password_reset
    # Find whether this is a legit email
    user = User.find_by(email: params[:email])
    if @user
      token = User.generate_reset_token
      # To be finished later; sends an email with password reset tokens
    end
    redirect_to password_reset_path
    flash[:alert] = "If you entered a valid email, check your inbox for password reset instructions"
  end

  def permitted_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
