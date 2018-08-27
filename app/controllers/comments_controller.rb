class CommentsController < ApplicationController
  before_action :set_pick

  def create
    @comment = @pick.comments.new(comment_params)
    if @comment.save
      respond_to do |format|
        format.html { redirect_to pick_path(@pick), notice: 'pickしました'}
        format.json
      end
    else
      flash.now[:alert] = 'コメントを入力してください。'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    @comment.update(comment_params)
  end

  private
  def comment_params
    params.require(:comment).permit(:comment).merge(user_id: current_user.id).merge(pick_id: @pick.id)
  end

  def set_pick
    @pick = Pick.find(params[:pick_id])
  end
end
