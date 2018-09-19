class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :ready_new_pick

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :company, :positon, :profile, :pro, :real_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :company, :positon, :profile, :pro, :real_name, :image])
  end

  def ready_new_pick
    @pick = Pick.new
  end
end

