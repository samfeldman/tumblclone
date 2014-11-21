class UsersController < ApplicationController
  
  def new
   #automatic sign-up page
  end

  def create

    @user = User.new(user_params)
    if @user.save && user_params[:email] != nil && user_params[:password] != nil
      sessions[:user_id] = @user.id
      redirect_to "/home/dash"
    else 
      flash[:alert] = "Please fill in all fields."
      redirect_to :back
    end
  end

  def show
    @user = User.find(params[:id])
    @posts = Post.where(user_id: params[:id])
    @followers = 

  end

  def show_edit
  end

  def set_edit
  end

  def index
  end

  def update
    user_params
  end

  def destroy
  end

  private

  
  def user_params
    params.require(:user).permit(:email, :password, :title, :username)
  end

end
