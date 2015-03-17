class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :current_user
  
  def back_to_index
    redirect_to cats_url if current_user
  end
  
  def login_user!(user)
    new_session = Session.create(user_id: user.id)
    session[:session_token] = new_session.token
  end
  
  def logout_session!(user)
    current_session.destroy
    session[:session_token] = nil
  end

  def current_session
    return nil if session[:session_token].nil?
    Session.find_by(token: session[:session_token])
  end
  
  def current_user
    return nil if current_session.nil?
    @current_user ||= current_session.user
  end
  
end
