class PicksController < ApplicationController
  def index
  end

  def show
  end

  def new
    @pick = Pick.new()
  end

  def create
    @pick = Pick.new(picks_params)
    @pick.get_article_info(params[:pick][:url])
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
