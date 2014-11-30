class FollowerController < ApplicationController
  def create
  	current_user
  	@follow = Follower.new(follower_id: @current_user.id, leader_id: params[:id])
  	if @follow.save
  		flash[:notice] = "follow successful!"
  	else
  		flash[:alert] = "follow unsuccessful :("
  	end
  	redirect_to :back
  end

  def destroy
  	current_user
  	@follow = Follower.new(follower_id: @current_user.id, leader_id: params[:id])
  	if @newfollow.save
  		flash[:notice] = "follow successful!"
  	else
  		flash[:alert] = "follow unsuccessful :("
  	end
  	redirect_to :back
  end
end
