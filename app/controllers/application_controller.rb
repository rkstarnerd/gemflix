class ApplicationController < ActionController::Base
  protect_from_forgery

  def log_in(user)
    session[:user_id] = user.id
    redirect_to home_path
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user    
  end

  def require_user
    if !logged_in?
      flash[:notice] = "Access reserved for members only.  Please sign in first."
      redirect_to signin_path
    end
  end
end
