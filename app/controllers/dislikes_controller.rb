class DislikesController < ApplicationController
  before_action :authenticate_user!

  def create
    user = User.find(params[:disliked_id])
    current_user.dislike(user)
    @dislike = curret_user.active_dislikes.find_by(disliked_id: params[:disliked_id])
    respond_to do |format|
      format.js
    end
  end

  def destroy
    user = User.find(params[:id])
    current_user.undislike(user)
    respond_to do |format|
      format.js
    end
  end

  def show
    @user = User.find(params[:id])
    respond_to do |format|
      format.js
    end
  end
end


