class DislikesController < ApplicationController
  before_action :authenticate_user!

  def create
    user = User.find(params[:id])
    current_user.dislike(user)
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

