class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    user = User.find(params[:followed_id])
    current_user.follow(user)
    @relationship = current_user.active_relationships.find_by(followed_id: params[:followed_id])
    respond_to do |format|
      format.html { redirect_to @user }
      format.json
    end
  end

  def destroy
    user = User.find(params[:followed_id])
    current_user.unfollow(user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.json
    end
  end
end
