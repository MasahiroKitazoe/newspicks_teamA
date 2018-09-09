class UsersController < ApplicationController

  before_action :authenticate_user!

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

  def timeline
    following_users = current_user.following
    if following_users.length > 0
      @follow_user_comments = []
      following_users.each do |user|
        user.comments.each do |comment|
          @follow_user_comments << comment
        end
      end
      @follow_user_comments = @follow_user_comments.sort_by{ |a| a[:created_at] }.reverse
    end
  end


end
