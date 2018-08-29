class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i(google)

  protected
  def self.find_for_google(auth)
    user = User.find_by(email: auth.info.email)

    if user
      user.provider = auth.provider
      user.uid = auth.uid
      user.access_token = auth.credentials.token
      return user
    else
      user = User.create(first_name: auth.info.first_name,
                         email: auth.info.email,
                         last_name:  auth.info.last_name,
                         provider:   auth.provider,
                         uid:        auth.uid,
                         access_token: auth.credentials.token,
                         password: Devise.friendly_token[0, 20])
      return user
    end
  end
end
