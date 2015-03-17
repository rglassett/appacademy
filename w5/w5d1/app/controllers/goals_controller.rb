class GoalsController < ApplicationController
  def create
    @goal = current_user.goals.new(goal_params)
    
    if @goal.save
      flash[:notices] = [ "Goal created!" ]
      redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end
  
  def destroy
    Goal.find(params[:id]).destroy
    flash[:notices] = [ "Goal destroyed!" ] 
    redirect_to current_user
  end
  
  def edit
    @goal = Goal.find(params[:id])
  end
  
  def index
    @goals = Goal.all_public
  end
  
  def new
    @goal = Goal.new
  end
  
  def show
    @goal = Goal.find(params[:id])
  end
  
  def update
    @goal = Goal.find(params[:id])
    
    if @goal.update_attributes(goal_params)
      flash[:notices] = [ "Goal updated!" ]
      redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :edit
    end
  end
  
  private
  
  def goal_params
    params.require(:goal).permit(:description, :private, :completed)
  end
end