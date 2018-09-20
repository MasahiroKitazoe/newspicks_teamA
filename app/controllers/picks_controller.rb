class PicksController < ApplicationController
  def index
    # top_picksと普通のpicksを分けておく事で、今後のアルゴリズム追加の土台にする
    @top_picks = Pick.order('created_at DESC').limit(5)
    top_picks_ids = @top_picks.map { |pick| pick.id }
    @picks = Pick.where.not(id: top_picks_ids).order('created_at DESC')

    #ユーザーランキング用
    @user_ranking, @weekly_likes = User.rank_user(4)

    #コメントランキング用
    @comment_ranking = Comment.rank_comment(4)
  end

  def show
    @pick = Pick.find(params[:id])
    @users = @pick.users
    @pick.comments.where(comment: "").each do |comment|
      if !@users.include?(comment.user)
        @users << comment.user
      end
    end
    @users_nocomment = []
    @users.each do |user|
      if user.comments.where(pick_id: @pick.id).first.nil? or user.comments.where("pick_id = ? and comment = ?", @pick.id, nil)
        if user_signed_in? and user == current_user
        else
          @users_nocomment << user
        end
      end
    end

    @comments = @pick.comments.includes(:user)
    #フォローは一旦自分自身のみで定義。コメントではfollowerに自分のコメントが表示される。なのでカレントユーザー情報を持ってくる必要はない。
    @comments_recommend = []
    @comments_following = []
    @comments_other = []
    @comments_garbage = []
    #注目のコメントとその他のコメントを分ける。
    @comments.each do |comment|
      if current_user.disliking?(comment.user)
        @comments_garbage << comment
      elsif (current_user.following?(comment.user) and !comment.comment.blank?) or comment.user == current_user
        @comments_following << comment
      elsif comment.present? and !comment.comment.blank?
        @comments_other << comment
      end
    end

    respond_to do |format|
      format.html
      format.json
    end
  end

  def search
    # URLの記事をスクレイピングする
    puts params[:url]
    article_info = scrape_info(params[:url])

    @pick = Pick.new()

    #titleを表示用に整形
    if article_info[:title].length > 40
      article_info[:title] = article_info[:title][0, 40] + "…"
    end

    #bodyを表示用に整形
    if article_info[:body].length > 120
      article_info[:body] = article_info[:body][0, 120] + "…"
    end

    #スクレイピングの結果を格納
    @pick.title = article_info[:title]
    @pick.body = article_info[:body]
    @pick.image = article_info[:image]
    @pick.source = article_info[:source]

    #ajax処理
    respond_to do |format|
      format.html { redirect_to root_path, flash: {alert: '検索に失敗しました'} }
      format.json
    end
  end

  def new
    @pick = Pick.new
  end

  def create
    @pick = Pick.new(picks_params)

    # URLの記事をスクレイピングする
    article_info = scrape_info(params[:pick][:url])

    #スクレイピングの結果を格納
    @pick.title = article_info[:title]
    @pick.body = article_info[:body]
    @pick.image = article_info[:image]
    @pick.source = article_info[:source]

    if @pick.save
      flash[:notice] = "Pickしました"
      comment = Comment.new(pick_id: @pick.id, user_id: current_user.id, comment: params[:pick][:comments][:comment])
      comment.save

      #カテゴリー分けバックグラウンド処理
      text = @pick.title + ' ' + @pick.source
      PickTheme.delay.register_theme(@pick, text)

      redirect_to :root
    else
      render action: :new
    end
  end

  def lookup
    params[:keyword] ||= ""
    keyword_array = params[:keyword].split(/[[:blank:]]+/)
    @picks = []
    @comments = []
    @users = []
    keyword_array.each do |keyword|
      picks = Pick.where('title LIKE :keyword OR body LIKE :keyword', keyword: "%#{keyword}%").order("created_at DESC").includes(:comments)
      comments = Comment.where('comment LIKE(?)', "%#{keyword}%").includes(:user, :pick)
      users = User.where("first_name LIKE :keyword OR last_name LIKE :keyword OR company LIKE :keyword OR position LIKE :keyword OR profile LIKE :keyword", keyword: "%#{keyword}%")
      @picks.concat(picks)
      @comments.concat(comments)
      @users.concat(users)
    end

    if params[:pick_num] && params[:pick_time]
      @picks = @picks.select{|pick| pick.comments.count >= params[:pick_num].to_i}.select{|pick| pick.created_at >= params[:pick_time].to_datetime}
    elsif params[:pick_num]
      @picks = @picks.select{|pick| pick.comments.count >= params[:pick_num].to_i}
    elsif params[:pick_time]
      @picks = @picks.select{|pick| pick.created_at >= params[:pick_time].to_datetime}
    end

    if params[:pick_sort_kind] == "comments_count"
      @picks = @picks.sort{|a, b| b.comments.count <=> a.comments.count}
    end

    if params[:comment_num] && params[:comment_time]
      @comments = @comments.select{|comment| comment.likes.count >= params[:comment_num].to_i}.select{|comment| comment.created_at >= params[:comment_time].to_datetime}
    elsif params[:comment_num]
      @comments = @comments.select{|comment| comment.likes.count >= params[:comment_num].to_i}
    elsif params[:comment_time]
      @comments = @comments.select{|comment| comment.created_at >= params[:comment_time].to_datetime}
    end

    if params[:comment_sort_kind] == "likes_count"
      @comments = @comments.sort{|a, b| b.likes.count <=> a.likes.count}
    end

    respond_to do |format|
      format.html
      format.json
      format.js
    end
  end


    private
    def picks_params
      params.require(:pick).permit(
        :url,
        :image,
        :title,
        :body,
        {:user_ids => []}
        )
    end

    def scrape_info(url)
      article_info = Pick.get_article_info(url)
      return article_info
    end
end
