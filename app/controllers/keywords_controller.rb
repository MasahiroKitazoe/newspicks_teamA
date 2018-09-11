class KeywordsController < ApplicationController
  def create
    keyword = Keyword.new(keyword: params[:keyword][:keyword], user_id: current_user.id)
    keyword.save
    redirect_to "/users/#{current_user.id}/timeline"
  end
end
