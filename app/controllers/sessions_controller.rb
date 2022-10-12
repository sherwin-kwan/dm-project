class SessionsController < ApplicationController
  def create
    # Check whether the username/password matches, and then if so, log them in; if not, show an error
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to root_path, notice: "You have successfully logged in"
    else
      flash[:alert] = "Username and password do not match. Sorry Charlotte, you don't get to know which one it is."
      render :new
    end
  end

  def new

  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "You have successfully logged out"
  end

end