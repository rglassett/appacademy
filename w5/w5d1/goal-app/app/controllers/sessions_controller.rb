class SessionsController < ApplicationController
  def create
    @user = User.find_by_credentials(
      user_params[:username], user_params[:password]
    )
    
    if @user
      sign_in_user!(@user)
      flash[:notices] = [ "Welcome back, #{@user.username}!" ]
      redirect_to :root
    else
      flash.now[:errors] = ["Invalid login credentials!"]
      @user = User.new(user_params)
      render :new
    end
  end
  
  def destroy
    sign_out_user!
    redirect_to :root
  end
  
  def new
    if current_user
      redirect_to current_user
    else
      @user = User.new
      render :new
    end
  end
  
end