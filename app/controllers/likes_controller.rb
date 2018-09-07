class LikesController < ApplicationController
  before_action :authenticate_user!
  after_action :create_notifications, only: [:create]

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

  private
  def create_notifications
    return if @comment.user.id == current_user.id
    Notification.create(user_id: @comment.user.id, notified_by_id: current_user.id, article_id: @comment.id, notified_type: 'いいね')
   end
end
