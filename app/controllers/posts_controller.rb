class PostsController < ApplicationController

  def create
      current_user
      if params[:text] == "" #feed textbox is empty
        flash[:notice] = "please enter a post!" #flash
        redirect "/feed/#{ @current_user.id }"
      else 
        @post = Post.new(text: params[:text], user_id: session[:user_id])
        @post.save
        flash[:] = "your post was saved!"
      end
      redirect '/home/dash'
  end

  def show
    current_user
    
    @comments = Comment.where(post_id: )
  end

  def index
  end

  def update
  end

  def destroy
  end
end
