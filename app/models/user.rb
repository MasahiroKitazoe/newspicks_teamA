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

  mount_uploader :image, ImageUploader

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

  def liked?(comment)
    if likes.find_by(comment_id: comment.id)
      return true
    else
      return false
    end
  end

  def self.rank_user(limit_num)
    #1週間以内に生成されたlikeのidを配列に格納
    like_ids = Like.where(created_at: [7.days.ago..Time.now]) { |like| like.id }

    #1週間以内にlikeされた全てのコメントのidを取得し、配列に格納
    grouped_likes = Like.group(:comment_id).where(created_at: [7.days.ago..Time.now])
    comment_ids = grouped_likes.map { |like| like.comment_id }

    #1週間以内にlikeされたコメントを取り出し、user_idでグループ化し、like数でソート
    target_comments = Comment.where(id: comment_ids)
    user_likes = {}
    target_comments.each do |comment|
      if user_likes[comment.user_id].nil?
        user_likes[comment.user_id] = comment.likes.where(id: like_ids).count
      else
        user_likes[comment.user_id] += comment.likes.where(id: like_ids).count
      end
    end

    #Like数の多い順にハッシュをソート
    user_likes.sort_by {|k,v| -v}

    #like数の多い順にユーザーを取り出す
    i = 0
    target_users = []
    weekly_likes = []
    user_likes.each do |key, val|
      target_users << User.find(key)
      weekly_likes << val
      i += 1
      return if i >= limit_num
    end

    return target_users, weekly_likes
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
