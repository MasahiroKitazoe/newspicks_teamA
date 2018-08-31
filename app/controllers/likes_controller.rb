class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = Comment.params[:comment_id]
    @comment.do_like(current_user)
  end

  def destroy
    @comment = Like.find(params[:id]).comment
    @comment.undo_like(current_user)
  end
end
