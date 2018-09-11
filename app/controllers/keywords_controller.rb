class KeywordsController < ApplicationController
  def create
    @keyword = Keyword.new(keyword: params[:keyword][:keyword], user_id: current_user.id)
    if keyword.save
      redirect_to "/users/#{current_user.id}/timeline"
    else
      binding.pry
    end
  end
end
