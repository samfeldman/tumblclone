class CommentsController < ApplicationController
  def create
  	@comment = Comment.new(user_id: 
  end

  def update

  end

  def destroy
  end
end
