class ApplicationController < ActionController::Base
  # protect_from_forgery
  
  helper_method :current_user
  
  def current_user
    return nil unless session[:session_token]
    User.find_by_session_token(session[:session_token])
  end
  
  def require_logged_in
    unless current_user
      flash[:errors] = ["You must be logged in to do that!"]
      redirect_to new_session_url
    end
  end
  
  def require_logged_out
    if current_user
      flash[:errors] = ["You must be logged out to do that!"]
      redirect_to root_url
    end
  end
  
  def login_user(user)
    user.reset_session_token!
    session[:session_token] = user.session_token
  end
  
  def logout_user!
    current_user.reset_session_token!
    session[:session_token] = nil
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :password)
  end
end