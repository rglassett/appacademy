class CatsController < ApplicationController
  
  before_action :ensure_owner, only: [:edit, :update]

  def create
    @cat = Cat.new(cat_params)
    @cat.user_id = current_user.id
    
    if @cat.save
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :new
    end
  end

  def index
    @cats = Cat.all
    render :index
  end

  def new
    @colors = Cat::COLORS
    @cat = Cat.new
    render :new
  end

  def edit
    @colors = Cat::COLORS
    @cat = Cat.find(params[:id])
    render :edit
  end

  def update
    @cat = Cat.find(params[:id])

    if @cat.update(cat_params)
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      @colors = Cat::COLORS
      render :edit
    end
  end

  def show
    @cat = Cat.find(params[:id])
    @display_attributes = @cat.attributes # remove timestamps
    render :show
  end

  private
  def cat_params
    params.require(:cat)
    .permit(:age, :birth_date, :name, :sex, :color, :description)
  end

  def ensure_owner
    unless current_user && Cat.find(params[:id]).user_id == current_user.id
      flash[:errors] = ["You must own this cat to edit it!"]
      redirect_to cat_url(params[:id])
    end
  end

end