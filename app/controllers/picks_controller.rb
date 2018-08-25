class PicksController < ApplicationController
  def index
  end

  def show
    @pick = Pick.find(params[:id])
    @comment = Comment.new
    @comments_recommend = @pick.comments.includes(:user).limit(2).order('id')
    @comments_following = @pick.comments.includes(:user).limit(2).order('updated_at')
    @comments_other = @pick.comments.includes(:user).order('id')
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
