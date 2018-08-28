class CommentsController < ApplicationController
  before_action :logged_in_user

  def create
    @pick = Pick.find(params[:pick_id])
    unless @pick.check?(current_user)
      @pick.check(current_user)
      @comment = @pick.comments
      @pick.reload
      @comment.reload
      respond_to do |format|
        format.html { redirect_to request.referrer || root_url}
        format.js
      end
    end
  end

  def update
    @pick = comment.find(params[:id]).pick
    if @pick.check?(current_user)
      @pick.upcheck(current_user)
      @comment = @pick.comments
      @pick.reload
      @comment.reload
      respond_to do |format|
        format.html {redirect_to request.referrer || root_url}
        format.js
      end
    end
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
