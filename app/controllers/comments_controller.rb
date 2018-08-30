class CommentsController < ApplicationController

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
    @pick = Comment.find(params[:id]).pick
    @comment = Comment.find(params[:id])
    if @pick.check?(current_user)
      @comment.update(comment_params)
      @pick.reload
      @comment.reload
      respond_to do |format|
        format.html {redirect_to request.referrer || root_url}
        format.js
      end
    end
  end

  def show
    @comment = Comment.find(params[:id])
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
