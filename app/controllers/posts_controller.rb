class PostsController < ApplicationController

  def create
    current_user
    @post = Post.new(post_params)
    if @post.save
      flash[:notice] = "your post was saved!"
    else 
      flash[:alert] = @post.errors.full_messages
    end
    redirect_to "/home/#{@current_user.id}/dash"
  end

  def update
    current_user
    @post = Post.find(params[:id])
    if @current_user.id == @post.user_id
      @post.update(post_params)
      flash[:notice] = "your post has been updated."
    else 
      flash[:alert] = "your post was not updated."
    end
    redirect_to :back

  end

  def destroy
    current_user
    @post = Post.find(params[:id])
    if @current_user.id == @post.user_id
      @post.destroy
    else
      flash[:alert] = "you do not own this post and cannot delete it."
    end
    redirect_to :back
  end

  def post_params
    params.require(:post).permit(:user_id, :text, :title)
  end


end
