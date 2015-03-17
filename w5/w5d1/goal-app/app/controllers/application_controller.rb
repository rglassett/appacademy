class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :current_user, :logged_in?
  
  def current_user
    return nil unless session[:session_token]
    @current_user ||= User.find_by(session_token: session[:session_token])
  end
  
  def find_commentable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end
  
  def logged_in?
    !!current_user
  end
  
  def sign_in_user! user
    user.reset_session_token!
    session[:session_token] = user.session_token
  end
  
  def sign_out_user!
    current_user.reset_session_token! if current_user
    session[:session_token] = nil
  end
  
  private
  
  def user_params
    params.require(:user).permit(:username, :password)
  end
  
end
