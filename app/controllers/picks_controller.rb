class PicksController < ApplicationController
  def index
  end

  def show
  end

  def new
    @pick = Pick.new()
  end

  def create
    binding.pry
    @pick = Pick.new(picks_params)
    if @pick.save
      flash[:notice] = "Pickしました"
      redirect_to :root
    else
      render action: :new
    end
  end

    private
    def picks_params
      params.require(:picks).permit(
        :url
        # :image,
        # :title,
        # :body
        )
    end
end
