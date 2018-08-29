class PicksController < ApplicationController
  def index
  end

  def show
    @pick = Pick.find(params[:id])
    @comments = @pick.comments.includes(:user)
    #フォローは一旦自分自身のみで定義。コメントではfollowerに自分のコメントが表示される。なのでカレントユーザー情報を持ってくる必要はない。
    @comments_following = @pick.comments.where(params[:id] == 1).includes(:user)
    #注目のコメントとその他のコメントを分ける。
    @comments_recommend = []
    @comments_other = []
    @comments.each_with_index do |comment,i|
      if i <= 2
        @comments_recommend << comment
      else
        @comments_other << comment
      end
    end
  end

  def new
    @pick = Pick.new
  end

  def create
    @pick = Pick.new(picks_params)

    # URLの記事をスクレイピングする
    article_info = @pick.get_article_info(params[:pick][:url])

    #スクレイピングの結果を格納
    @pick.title = article_info[:title]
    @pick.body = article_info[:body]
    @pick.image = article_info[:image]

    if @pick.save
      flash[:notice] = "Pickしました"
      redirect_to :root
    else
      render action: :new
    end
  end

  private
  def picks_params
    params.require(:pick).permit(
      :url,
      :image,
      :title,
      :body
      )
  end
end
