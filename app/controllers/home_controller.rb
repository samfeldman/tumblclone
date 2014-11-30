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
	  	redirect_to "/home/#{@user.id}/dash"
	  else 
	  	flash[:alert] = "login failed; please try again."
	  	redirect_to "/"
	  end
	end

	def dash
		current_user
		@users = User.all.order(:username)
		@post = Post.new
		if @current_user 
	      @followers = @current_user.followers
	      @leaders = @current_user.leaders
	       	if !@leaders.empty?
	            @following_posts = @leaders.map(&:posts).flatten.sort_by(&:created_at)
	        else 
	            @following_posts = []
	        end
	    end

	end

	private
		
		def user_params
	    params.require(:user).permit(:email, :password, :title, :username)
		end

end
