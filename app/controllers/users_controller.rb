class UsersController < ApplicationController

  def library
    @users = User.order('created_at ASC')
  end

  def show
    @user = User.find(params[:id])
  end

  def follow
    user = User.find(params[:id])
    current_user.follow(user)
    redirect_back(fallback_location: root_path)
  end

  def unfollow
    user = User.find(params[:id])
    current_user.unfollow(user)
    redirect_back(fallback_location: root_path)
  end
end
