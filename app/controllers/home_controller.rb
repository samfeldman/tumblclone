class HomeController < ApplicationController

	def show
		#automatic to login page
	end

	def destroy
	  	session[:user_id] = nil
	  	redirect_to "/"
	end

	def create
		@user = User.where(email: user_params[:email]).first
	  if @user && @user.password == user_params[:password]
	  	session[:user_id] = @user.id
	  	redirect_to "/home/dash"
	  else 
	  	flash[:alert] = "login failed; please try again."
	  	redirect_to "/"
	  end
	end

	def dash
		@users = User.all.username.sort_by{|username| username.downcase}
	# if @current_user 
  #     @followers = @current_user.followers
  #     @followees = @current_user.followees
  #      	if !@following.empty?
  #           @following_posts = @followees.map(&:posts).flatten.sort_by(&:created_at)
  #       else 
  #           @following_posts = []
  #       end
  #   end

	end

	private
		
		def user_params
	    params.require(:user).permit(:email, :password, :title, :username)
		end

end
