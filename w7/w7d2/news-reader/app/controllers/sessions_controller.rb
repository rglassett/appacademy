class SessionsController < ApplicationController
  before_action :require_logged_out, except: [:destroy]
  
  def create
    @user = User.find_by_credentials(user_params[0], user_params[1])
    if @user
      login_user(@user)
      redirect_to :root
    else
      @user = User.new
      flash.now[:errors] = ["Invalid login credentials"]
      render :new
    end
  end
  
  def destroy
    logout_user!
    redirect_to new_session_url
  end
  
  def new
    @user = User.new
    render :new
  end
end