class KeywordsController < ApplicationController
  def create
    @keyword = current_user.keywords.build(keyword_params)
    respond_to do |format|
      if @keyword.save
        format.js
      else
        format.js
      end
    end
  end

  def destroy
    keyword = Keyword.find_by(keyword: params[:keyword][:keyword], user_id: current_user)
    if keyword.destroy
      redirect_to timeline_user_path
    else
      render controller: 'users', action: 'timeline'
    end
  end

  private
  def keyword_params
    params.require(:keyword).permit(:keyword)
  end
end
