class UsersController < ApplicationController
  def new
    @user = User.new

    redirect_to home_path if current_user
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to signin_path
    else
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :email)
  end
end

