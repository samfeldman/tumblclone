class UsersController < ApplicationController
  
  def new
   #automatic sign-up page
  end

  def create
    @user = User.new(user_params)
    if @user.save 
      session[:user_id] = @user.id
      redirect_to "/home/dash"
    else 
      flash[:alert] = @user.errors.full_messages
      redirect_to :back
    end
  end

  def show
    current_user
    @user = User.find(params[:id])
    @posts = Post.where(user_id: params[:id])
    @followers = @user.followers.all.sort_bye{|username| Follow.username.downcase}
  end

  def edit
    current_user
    @user = User.find(params[:id])
  end

  def edit_update
    current_user
    @user = User.find(params[:id])
    if @current_user.id == @user.id
      @user.update(user_params)
      flash[:notice] = "updates saved!"
    else
      flash[:alert] = "updates not saved; please try again."
    end
    redirect_to "/users/#{@user.id}/edit"
  end

  def show_update
    current_user
    @user = User.find(params[:id])
    if @current_user.id == @user.id
      @user.update(user_params)
      flash[:notice] = "updates saved!"
    else
      flash[:alert] = "updates not saved; please try again."
    end
    redirect_to "/users/#{@user.id}/show"
  end

  def destroy
    current_user
    @user = User.find(params[:id])
    if @current_user.id == @user.id
      @user.destroy
    else
      flash[:alert] = "you are not given permission to destroy this user."
      redirect_to :back
    end
    redirect_to '/'
  end

  private

  
  def user_params
    params.require(:user).permit(:email, :password, :title, :username)
  end

end
