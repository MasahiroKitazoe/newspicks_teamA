class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = Comment.find(params[:comment_id])
    @comment.do_like(current_user)
    @like = Like.find_by(comment_id: @comment.id)

    #ajax処理
    respond_to do |format|
      format.html { redirect_to root_path, flash: {alert: 'いいね解除に失敗しました'} }
      format.json
    end
  end

  def destroy
    @comment = Like.find(params[:id]).comment
    @comment.undo_like(current_user)
  end

    #ajax処理
    respond_to do |format|
      format.html { redirect_to root_path, flash: {alert: 'いいねに失敗しました'} }
      format.json
    end
end
