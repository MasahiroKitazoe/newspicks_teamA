class UsersController < ApplicationController

  before_action :authenticate_user!

  def library
    @users = User.order('created_at ASC')

    #1週間以内のCommentのidを取得
    target_ids = Comment.where(created_at: [1.days.ago..Time.now]).ids

    #Like数の多いコメントを取得
    ids = Like.group(:comment_id).where(comment_id: target_ids).order('count_comment_id DESC').limit(30).count(:comment_id).keys
    @ranking = ids.map { |id| Comment.find(id) }

    #該当commentが0件のとき、代わりに時期無制限でlikeの多いcommentを取得
    if @ranking.empty?
      ids = Like.group(:comment_id).order('count_comment_id DESC').limit(30).count(:comment_id).keys
      @ranking = ids.map { |id| Comment.find(id) }
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def follow
    user = User.find(params[:id])
    current_user.follow(user)
    redirect_back(fallback_location: root_path)
  end

  def unfollow
    user = User.find(params[:id])
    current_user.unfollow(user)
    redirect_back(fallback_location: root_path)
  end
end
