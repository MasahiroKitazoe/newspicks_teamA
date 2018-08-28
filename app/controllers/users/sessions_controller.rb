# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  include AjaxHelper

  # GET /resource/sign_in
  def new
    super
  end

  # POST /resource/sign_in
  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)
    respond_to do |format|
      if user_signed_in?
        yield resource if block_given?
        format.js { render ajax_redirect_to(root_path) }
      end
    end
  end

  def get_error
    respond_to do |format|
      @msg = resource.errors.full_messages
      format.js
    end
  end

  # DELETE /resource/sign_out
  def destroy
    super
  end

  protected

  def auth_options
    { scope: resource_name, recall: "#{controller_path}#get_error" }
  end
  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
