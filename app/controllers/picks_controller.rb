class PicksController < ApplicationController
  def index
    # top_picksと普通のpicksを分けておく事で、今後のアルゴリズム追加の土台にする
    @top_picks = Pick.order('created_at DESC').limit(3)
    top_picks_ids = @top_picks.map { |pick| pick.id }

    @picks = Pick.where.not(id: top_picks_ids).order('created_at DESC')
  end

  def show
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
    @pick = Pick.new()
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

    def scrape_info(url)
      article_info = Pick.get_article_info(url)
      return article_info
    end
end
