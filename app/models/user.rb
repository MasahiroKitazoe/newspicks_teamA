class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i(google)

  has_many :comments
  has_many :active_relationships, class_name:  "Relationship",
                                foreign_key: "follower_id",
                                dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :likes

  # ユーザーをフォローする
  def follow(other_user)
    following << other_user
  end

  # ユーザーをフォロー解除する
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # 現在のユーザーがフォローしてたらtrueを返す
  def following?(other_user)
    following.include?(other_user)
  end

  protected
  # ユーザーのGoogleメールアドレスからユーザーを検索
  # 登録ずみユーザーはGoogleアカウントと関連付け
  # 未登録ユーザーはGoogleアカウント情報からユーザー登録
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
