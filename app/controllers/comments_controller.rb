class CommentsController < ApplicationController
  before_action :logged_in_user

  def create
    @pick = Pick.find(params[:pick_id])
    @pick.check(current_user)
  end

  def update
    @pick = comment.find(params[:id]).pick
    @pick.uncheck(current_user)
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  private
  def comment_params
    params.require(:comment).permit(:comment).merge(user_id: current_user.id).merge(pick_id: @pick.id)
  end

  def set_pick
    @pick = Pick.find(params[:pick_id])
  end
end
