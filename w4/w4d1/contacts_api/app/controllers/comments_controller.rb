class CommentsController < ApplicationController
  def index
    @commentable = find_commentable
    @comments = @commentable.comments
    render json: @comments
  end
  
  def create
    @commentable = find_commentable
    @comment = Comment.new(comment_params)
    if @comment.save
      render json: @comment
    else
      render json: @comment.errors.full_messages, status: :unprocessable_entity
    end
  end
  
  def find_commentable # users/1/comments
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value) # User.find(1)
      end
    end
    nil
  end

  def comment_params
    comment_stuff = params.require(:comment).permit(:content, :commentable_id, :commentable_type)
    if params.include?(:user_id)
      comment_stuff[:commentable_type] = "User"
      comment_stuff[:commentable_id] = params[:user_id]
    elsif params.include?(:contact_id)
      comment_stuff[:commentable_type] = "Contact"
      comment_stuff[:commentable_id] = params[:contact_id]
    end
    comment_stuff
  end
end
