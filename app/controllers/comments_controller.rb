class CommentsController < ApplicationController
  before_action :set_pick

  def create
    @comment = @pick.comments.create(comment_params)
    html = render_to_string partial: 'picks/comment', locals: { comment: @comment }
    render :json => {:html => html}
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
    params.require(:comment).permit(:text).merge(user_id: current_user.id).merge(pick_id: @pick.id)
  end

  def set_pick
    @pick = Pick.find(params[:pick_id])
  end
end
