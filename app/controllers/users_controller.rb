class UsersController < ApplicationController

  def library
    @users = User.order('created_at ASC')
  end

  def show
    @user = User.find(params[:id])
  end
end
