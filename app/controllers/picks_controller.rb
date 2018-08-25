class PicksController < ApplicationController
  def index
    @pick = Pick.new
  end

  def show
  end

  def new
    @pick = Pick.new()
  end

  def create
    @pick = Pick.new(picks_params)

    # URLの記事をスクレイピングする
    article_info = @pick.get_article_info(params[:pick][:url])

    #スクレイピングの結果を格納
    @pick.title = article_info[:title]
    @pick.body = article_info[:body]
    @pick.image = article_info[:image]
    @pick.source = article_info[:source]

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
