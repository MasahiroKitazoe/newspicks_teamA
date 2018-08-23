class PicksController < ApplicationController
  def index
  end

  def show
  end

  def new
    
  end

  def create
    
  end

    private
    def picks_params
      params.require(:picks).permit(
        :url,
        :image,
        :title,
        :body
        )
    end
end
