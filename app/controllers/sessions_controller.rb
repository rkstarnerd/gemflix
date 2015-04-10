class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.where(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to home_path, notice: "You are signed in"
    else
      flash[:error] = "Your username and/or password was incorrect. Please try again."
      redirect_to signin_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end