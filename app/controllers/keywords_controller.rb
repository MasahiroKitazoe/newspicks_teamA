class KeywordsController < ApplicationController
  def create
    @keyword = Keyword.new(keyword: params[:keyword][:keyword], user_id: current_user.id)
    @keyword.save
  end

  def destroy
    keyword = Keyword.find_by(keyword: params[:keyword][:keyword], user_id: current_user)
    keyword.destroy
    redirect_to "/users/#{current_user.id}/timeline"
  end
end
