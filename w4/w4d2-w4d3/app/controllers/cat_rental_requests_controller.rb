class CatRentalRequestsController < ApplicationController

  before_action :ensure_owner, only: [:approve, :deny]

  def create
    @request = CatRentalRequest.new(request_params)
    @request.user_id = current_user.id
    if @request.save
      redirect_to cat_url(Cat.find(@request.cat_id)) 
    else
      @cats = Cat.all
      flash.now[:errors] = @request.errors.full_messages
      render :new
    end
  end

  def new
    @cats = Cat.all
    @request = CatRentalRequest.new
    render :new
  end
  
  def approve
    request = CatRentalRequest.find(params[:cat_rental_request_id])
    request.approve!
    
    flash[:errors] = request.errors.full_messages
    redirect_to cat_url(request.cat)
  end
  
  def deny
    request = CatRentalRequest.find(params[:cat_rental_request_id])
    request.deny!
    redirect_to cat_url(request.cat)
  end
  
  private
  def request_params
    params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date)
  end
  
  def ensure_owner(cat)
    cat = CatRentalRequest.find(params[:cat_rental_request_id]).cat
    
    unless current_user && cat.user_id == current_user.id
      flash[:errors] = ["You must own this cat to approve or deny requests!"]
      redirect_to cat_url(cat.id)
    end
  end
end