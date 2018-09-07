class CommentsController < ApplicationController

  def create
    @pick = Pick.find(comment_params[:pick_id])
    if Comment.where("pick_id = ? and user_id = ?",comment_params[:pick_id], current_user.id).blank?
      PickUser.create(pick_users_params)
      @comment = Comment.create(comment_params)
      @pick.reload
      respond_to do |format|
        format.html { redirect_to request.referrer || root_url}
        format.js
      end
    else
      @comment = Comment.new(comment_params)
      @pick.reload
      respond_to do |format|
        format.js { render :edit }
      end
    end
  end

  def update
    @pick = Comment.find(params[:id]).pick
    @comment = Comment.find(params[:id])
    if @pick.check?(current_user)
      @comment.update(comment_params)
      @pick.reload
      respond_to do |format|
        format.html {redirect_to request.referrer || root_url}
        format.js
      end
    end
  end

  # modal削除確認画面として、showメソッドを使用
  def show
    @pick = Comment.find(params[:id]).pick
    @comment = Comment.find(params[:id])
    respond_to do |format|
      format.html {redirect_to request.referrer || root_url}
      format.js
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @pick = @comment.pick
    @pick_user = PickUser.where("pick_id = ? and user_id = ?", @pick.id, current_user.id)
    @pick_user.destroy(@pick_user.ids)
    @comment.destroy
    respond_to do |format|
      format.html {redirect_to request.refferrer || root_url}
      format.js
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  private
  def comment_params
    params.require(:comment).permit(:comment, :pick_id).merge(user_id: current_user.id)
  end

  def pick_users_params
    params.require(:comment).permit(:pick_id).merge(user_id: current_user.id)
  end

  def set_pick
    @pick = Pick.find(params[:pick_id])
  end
end
