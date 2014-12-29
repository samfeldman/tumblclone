class CommentsController < ApplicationController
  def create
  	current_user
  	@comment = Comment.new(comment_params)
  	@comment.user_id = @current_user.id
    @comment.post_id = params[:post_id]
  	if @comment.save
  		flash[:notice] = "your comment was saved!"
  	else
  		flash[:alert] = "your comment was not saved :("
  	end
  	redirect_to :back
  end

  def update
  	current_user
  	@comment = Comment.find(params[:id])
    if @current_user.id == @comment.user_id
      if @comment.update(comment_params)
        flash[:notice] = "your comment has been updated."
      else
        flash[:alert] = "your comment was not updated :("
      end
    else 
      flash[:alert] = "you are not the creator of this comment."
    end
    redirect_to :back
  end

  def destroy
    current_user
    @comment = Comment.find(params[:id])
    if @current_user.id == @comment.user_id
      @comment.destroy
      flash[:notice] = "your comment was destroyed."
    else
      flash[:alert] = "you do not own this comment and cannot delete it."
    end
    redirect_to :back
  end

  def comment_params
    params.require(:comment).permit(:text)
  end

end
