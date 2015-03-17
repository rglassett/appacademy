class SessionsController < ApplicationController
  
  before_action :back_to_index, only: [:new]
  
  def new
    @user = User.new
    render :new
  end
  
  def create
    @user = User.find_by_credentials(*user_credentials)
    if @user
      login_user!(@user)
      redirect_to cats_url
    else
      render :new
    end
  end
  
  def destroy
    logout_session!(current_session)
    redirect_to new_session_url
  end
  
  private
  
  def session_params
    params.require(:user).permit(:user_name, :password)
  end
  
  def user_credentials
    [session_params[:user_name], session_params[:password]]
  end
end
