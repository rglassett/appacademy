class UsersController < ApplicationController
  before_action :require_logged_out, except: [:show]
  
  def create
    @user = User.new(user_params)
    if @user.save
      login_user(@user)
      redirect_to :root
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end
  
  def new
    @user = User.new
    render :new
  end
  
  def show
    @user = current_user
  end
  
end