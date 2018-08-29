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
    @msg = []
    respond_to do |format|
      format.js do
        if params[:user][:email] == "" && params[:user][:password] == ""
          @msg << "メールアドレスを入力してください"
          @msg << "パスワードを入力してください"
        elsif params[:user][:email] == ""
          @msg << "メールアドレスを入力してください"
        elsif params[:user][:password] == ""
          @msg << "パスワードを入力してください"
        else
          # if User.find_by(email: params[:user][:email], password: params[:user][:password]).persisted? == false
            @msg << "メールアドレス、またはパスワードが間違っています"
          # else
            self.resource = warden.authenticate!(auth_options)
            set_flash_message!(:notice, :signed_in)
            sign_in(resource_name, resource)
            yield resource if block_given?
          # end
        end
      end
    end

  end

  # DELETE /resource/sign_out
  def destroy
    super
  end

  protected

  def auth_options
    { scope: resource_name, recall: "#{controller_path}#new" }
  end
  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
