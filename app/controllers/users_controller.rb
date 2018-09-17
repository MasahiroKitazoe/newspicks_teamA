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

  def timeline
    @keyword = Keyword.new
    # 登録しているキーワードにヒットしているニュースの最新コメントを取得
    # users_nocommentは一旦無視
    @my_comments = []
    keywords = current_user.keywords
    keywords.each do |keyword|
      picks = Pick.where('title LIKE :keyword OR body LIKE :keyword', keyword: "%#{keyword.keyword}%").order("created_at DESC").includes(:comments)
      picks.each do |pick|
        if pick.comments.length > 0
          pick.comments.last.keyword = keyword.keyword
          @my_comments << pick.comments.last
        end
      end
    end
    following_users = current_user.following
    if following_users.length > 0
      following_users.each do |user|
        user.comments.each do |comment|
          @my_comments << comment
        end
      end
    end
    @my_comments = @my_comments.uniq {|comment| comment.pick.id}
    @my_comments = @my_comments.sort_by{ |a| a[:created_at] }.reverse

    if params[:comment_id]
      @latest_comments = @my_comments.select {|comment| comment.id > params[:comment_id].to_i}
    end

    respond_to do |format|
      format.html
      format.json
    end
  end


  private
  def create_notifications
    user = User.find(params[:followed_id])
    Notification.create(user_id: user.id, notified_by_id: current_user.id, notified_type: 'フォロー')
  end

end
