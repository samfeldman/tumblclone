class PostsController < ApplicationController

  def create
    current_user
    @post = Post.new(post_params)
    @post.user_id = @current_user.id
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
      if @post.update(post_params)
        flash[:notice] = "your post has been updated."
      else 
        flash[:alert] = "your post was not updated :("
      end
    else
      flash[:alert] = "you are not the owner of this post."
    end
    redirect_to :back

  end

  def show
    current_user
    @post = Post.find(params[:id])
    @comments = @post.comments.all.reverse
    @comment = Comment.new
    session[:show_source] = request.referrer
  end

  def destroy
    current_user
    puts request.referrer
    @post = Post.find(params[:id])
    if @current_user.id == @post.user_id
      @post.destroy
      flash[:notice] = "your post was destroyed."
    else
      flash[:alert] = "you do not own this post and cannot delete it."
    end
    if /\/posts\/\d+/.match(request.referrer) != nil
      redirect_to session[:show_source]
    else
      redirect_to :back
    end
  end

  def post_params
    params.require(:post).permit(:text, :title)
  end


end
