class UsersController < ApplicationController
  before_filter :require_user, only: [:show]

  def new
    @user = User.new

    redirect_to home_path if current_user
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      AppMailer.send_welcome_email(@user).deliver
      redirect_to signin_path
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :email)
  end
end

