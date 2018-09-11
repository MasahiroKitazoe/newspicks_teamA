class KeywordsController < ApplicationController
  def create
    keyword = Keyword.new(keyword: params[:keyword], user_id: current_user.id)
    keyword.save
  end
end
