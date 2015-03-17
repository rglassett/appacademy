class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.author_id = current_user.id
    
    if @comment.save
      flash[:notices] = [ "Comment created!" ]
      redirect_to @comment
    else
      flash.now[:errors] = @comment.errors.full_messages
      render :new
    end
  end
  
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to @comment.commentable
  end
  
  def edit
    @comment = Comment.find(params[:id])
    render :edit
  end
  
  def new
    @comment = find_commentable.comments.new
    render :new
  end
  
  def show
    @comment = Comment.find(params[:id])
  end
  
  def update
    @comment = Comment.find(params[:id])
    
    if @comment.update_attributes(comment_params)
      flash[:notices] = [ "Comment updated!" ]
      redirect_to @comment
    else
      flash.now[:errors] = @comment.errors.full_messages
      render :edit
    end
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:body, :commentable_id, :commentable_type)
  end
end