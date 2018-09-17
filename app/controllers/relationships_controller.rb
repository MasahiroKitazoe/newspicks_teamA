class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  after_action :create_notifications, only: [:create]

  def create
    user = User.find(params[:followed_id])
    current_user.follow(user)
    respond_to do |format|
      format.html { redirect_to user }
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

  private
  def create_notifications
    user = User.find(params[:followed_id])
    Notification.create(user_id: user.id, notified_by_id: current_user.id, notified_type: 'フォロー')
  end
end
