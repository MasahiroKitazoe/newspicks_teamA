class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :ready_new_pick
  before_action :basic_auth

  def production?
    Rails.env.production?
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :company, :positon, :profile, :pro, :real_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :company, :positon, :profile, :pro, :real_name, :image])
  end

  def ready_new_pick
    @new_pick = Pick.new
  end

  private

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end
end

