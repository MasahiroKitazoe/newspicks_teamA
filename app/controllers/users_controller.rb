class UsersController < ApplicationController

  before_action :authenticate_user!
  after_action :create_notifications, only: [:follow]

  def library
    @users = User.order('created_at ASC')

    @comment_ranking = Comment.rank_comment(30)

    #まずは、likesテーブルから1週間以内にlikeされたものを取り出す
    @user_ranking, @weekly_likes = User.rank_user(30)
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

  private
  def create_notifications
    user = User.find(params[:followed_id])
    Notification.create(user_id: user.id, notified_by_id: current_user.id, notified_type: 'フォロー')
  end

end
