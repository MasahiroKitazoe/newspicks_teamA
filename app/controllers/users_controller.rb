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
    @keyword = Keyword.new
    following_users = current_user.following
    @my_comments = []
    if following_users.length > 0
      following_users.each do |user|
        user.comments.each do |comment|
          @my_comments << comment
        end
      end
    end

    # 登録しているキーワードにヒットしているニュースの最新コメントを取得
    # users_nocommentは一旦無視
    keywords = current_user.keywords
    keywords.each do |keyword|
      picks = Pick.where('title LIKE :keyword OR body LIKE :keyword', keyword: keyword).order("created_at DESC").includes(:comments)
      picks.each do |pick|
        if pick.comments
          @my_comments << pick.comments.last
        end
      end
    end

    @my_comments = @my_comments.sort_by{ |a| a[:created_at] }.reverse
  end


end
